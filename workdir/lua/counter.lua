local pcall = pcall
local ngx = ngx
local ngx_log = ngx.log
local ngx_err = ngx.ERR
local _M = {}
function _M.init()
    uris = ngx.shared.uri_by_host
    global_set = ngx.shared.global_set
    global_set:set("initted", false)
    global_set:set("looped", false)
    prometheus = require("prometheus").init("prometheus_metrics") 
    metric_latency = prometheus:histogram("nginx_http_request_duration_seconds", "HTTP request latency status", {"host", "status", "scheme", "method", "endpoint", "fullurl"})
end
local function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
local function parse_fullurl(request_uri)
    result_table = {}
    if string.find(request_uri, "%.") ~= nil then
       return nil
    end
    parts = split(request_uri, "/")
    if table.getn(parts) == 1 then
       return nil
    end
    for j=1, #parts do
       if(j == 1) then
           endpoint = "/"..parts[j]
           fullurl = "/"..parts[j]
       elseif(j <= 5) then
           if tonumber(parts[j]) ~= nil then
               break
           end
           fullurl = fullurl.."/"..parts[j]
       else
           break
       end
    end
    result_table["endpoint"] = endpoint
    result_table["fullurl"] = fullurl
    return result_table
end
function _M.log()
    local request_host = ngx.var.host
    local request_uri = ngx.unescape_uri(ngx.var.uri)
    local request_status = ngx.var.status
    local request_scheme = ngx.var.scheme
    local request_method = ngx.var.request_method
    local remote_ip = ngx.var.remote_addr
    local ngx_sent = ngx.var.body_bytes_sent
    local latency = ngx.var.upstream_response_time or 0


    result_table = parse_fullurl(request_uri)
    if result_table == nil then
        return
    end
    ngx_log(ngx_err,"latency=", tonumber(latency), ",status=", request_status, ",endpoint=", result_table["endpoint"], ",fullurl=", result_table["fullurl"])
    metric_latency:observe(tonumber(latency), {request_host, request_status, request_scheme, request_method, result_table["endpoint"], result_table["fullurl"]})
end
return _M

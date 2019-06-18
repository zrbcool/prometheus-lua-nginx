local cjson = require('cjson')
local pcall = pcall
local json_decode = cjson.decode
local ngx = ngx
local ngx_log = ngx.log
local ngx_err = ngx.ERR
local timer_at = ngx.timer.at
local ngx_sleep = ngx.sleep
local delay = 300  -- 轮询consul时间间隔，10s
local _M = {}

-- 初始化Prometheus指标，全局字典对象，initted 已经被初始化标记，looped 已经开始循环标记
function _M.init()
    uris = ngx.shared.uri_by_host
    global_set = ngx.shared.global_set
    global_set:set("initted", false)
    global_set:set("looped", false)
    prometheus = require("prometheus").init("prometheus_metrics") 
    metric_get_consul = prometheus:counter("nginx_consul_get_total", "Number of query uri from consul", {"status"})
    metric_latency = prometheus:histogram("nginx_http_request_duration_seconds", "HTTP request latency status", {"host", "status", "scheme", "method", "endpoint"})
end
function _M.log()
    local request_host = ngx.var.host
    local request_uri = ngx.unescape_uri(ngx.var.uri)
    local request_status = ngx.var.status
    local request_scheme = ngx.var.scheme
    local request_method = ngx.var.request_method
    local get_all_hosts = uris:get_keys()
    if get_all_hosts == nil then
        ngx_log(ngx_err, "Dict is empty！")
        return
    end
    for j=1, #get_all_hosts do
        if get_all_hosts[j] == request_host then
            local def_uri = json_decode(uris:get(get_all_hosts[j]))
            if def_uri == nil then
                ngx_log(ngx_err, "Decode uris err!")
                return
            end
            for k=1, #def_uri do
                local s = "^"..def_uri[k].."$"
                if ngx.re.find(request_uri, s, "isjo" ) ~= nil then
                    metric_latency:observe(ngx.now() - ngx.req.start_time(), {request_host, request_status, request_scheme, request_method, def_uri[k]})
                end
            end
        end
    end
end
return _M

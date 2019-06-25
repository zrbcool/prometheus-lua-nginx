# prometheus-lua-nginx
![GitHub stars](https://img.shields.io/github/stars/zrbcool/prometheus-lua-nginx.svg?style=social)
![GitHub followers](https://img.shields.io/github/followers/zrbcool.svg?style=social)
## Overview
Project **prometheus-lua-nginx** is a complete solution for openresty based api gateway monitoring, **prometheus-lua-nginx** use prometheus lua lib and openresty http request life cycle to inject monitoring code, it is async, high performance, and business awareness, it also have built-in grafana dashboard out of box, please see [Snapshots](https://github.com/zrbcool/prometheus-lua-nginx/blob/master/Snapshots.md)
## Architecture

## Features
- Base on promethues pull mode to collect metrics
- Multiple dimension latency metrics collection(host,status code,schema,etc.)
- Out-of-box grafana dashboards
- LUA based latency metrics collection, high performance, low memory use, async
## Getting started
### Quickly start up a demo by docker-compose
```shell
# please instal docker-ce, docker-compose correctly
docker-compose up
```
this compose will install a set of containers for a demo use:
- a grafana has built in dashboards
- a backend services for mock latency and the real workload
- a openresty as proxy with counter.lua and promethues.lua integrated, can collect latency metrics, and expose them by :9145/metrics endpoint
- a promethues has pre configured previous oprenresty as scrape target

how to access:
- access grafana by [hostip]:3000
- access promethues by [hostip]:9090
- access openresty exposed metrics by [hostip]:9145/metrics
- access [hostip]:8081/latency/[latency]/bytes/[bytes] to mock a api call, for instance -> :8081/latency/100/bytes/10
## Building
### About Demo build
You should aware that the demo is only for demo use, if you want to use it in your production environment, you need to completely know how the demo and the solution runs. If you are ready, please see ./docker/xxx for more details
### Build OpenResty from source and integrate LUA metrics collection code
- build OpenResty from source, please follow [BuildOpenResty](https://github.com/zrbcool/prometheus-lua-nginx/blob/master/BuildOpenResty.md)
- copy workdir/conf.d/counter.conf to your conf.d dir
- copy workdir/lua/prometheus.lua to your openresty lib dir
- change lua_package_path in counter.conf to define lib location
- copy /workdir/lua/counter.lua to your openresty lua dir
here is our workdir structure
```shell
workdir
├── conf.d
│   ├── backend.conf # backend service config, replace it by your real workload
│   └── counter.conf # define lua-prometheus related vars and import deps
├── html
│   ├── 50x.html # demo use static html
│   └── index.html # demo use static html
├── lua
│   ├── counter.lua # metric collection code
│   └── prometheus.lua # prometheus.lua is offical Prometheus LUA Library you can upgrade it from https://github.com/knyar/nginx-lua-prometheus
└── nginx.conf # main config
```
- if you just want run current project, please follow:
```java
export RESTY_HOME=/opt/openresty
cd $RESTY_HOME
git clone https://github.com/zrbcool/prometheus-lua-nginx.git
ln -s $RESTY_HOME/prometheus-lua-nginx/workdir $RESTY_HOME/workdir
mkdir $RESTY_HOME/workdir/logs
cd $RESTY_HOME
git clone https://github.com/knyar/nginx-lua-prometheus.git
cp nginx-lua-prometheus/prometheus.lua workdir/lua
$RESTY_HOME/build/nginx/sbin/nginx \
	-p $RESTY_HOME/workdir \
	-c $RESTY_HOME/workdir/nginx.conf

curl localhost:8080
	<p>hello, world</p>
curl localhost:9145/metrics
	# HELP nginx_metric_errors_total Number of nginx-lua-prometheus errors
	# TYPE nginx_metric_errors_total counter
	nginx_metric_errors_total 0
pkill nginx
```
## Contact
### E-Mail
- zhangrongbincool@163.com
- zhangrongbincool@gmail.com
- zhangrongbin@coohua.com
### Blog
[blog.zrbcool.top](http://blog.zrbcool.top)
### Other Topics
[github](https://github.com/zrbcool/blog-public)

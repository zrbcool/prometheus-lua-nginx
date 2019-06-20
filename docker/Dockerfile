FROM openresty/openresty:stretch-fat

COPY workdir/conf.d/counter.conf /etc/nginx/conf.d/counter.conf
COPY workdir/conf.d/backend.conf /etc/nginx/conf.d/backend.conf
COPY workdir/lua/prometheus.lua /etc/nginx/conf.d/prometheus.lua
COPY workdir/lua/counter.lua /etc/nginx/conf.d/counter.lua

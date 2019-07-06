FROM prom/prometheus

COPY prometheus.yml /etc/prometheus/prometheus.yml
COPY nginx.alert.rule /etc/prometheus/nginx.alert.rule
COPY nginx.counter.rule /etc/prometheus/nginx.counter.rule
COPY nginx.errrate.rule /etc/prometheus/nginx.errrate.rule
COPY nginx.latency.rule /etc/prometheus/nginx.latency.rule
COPY nginx.qps.rule /etc/prometheus/nginx.qps.rule


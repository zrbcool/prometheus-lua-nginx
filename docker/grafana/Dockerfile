FROM grafana/grafana

COPY grafana.ini /etc/grafana/grafana.ini
COPY provisioning.yml /etc/grafana/provisioning/dashboards/provisioning.yml
COPY datasource.yml /etc/grafana/provisioning/datasources/datasource.yml

RUN mkdir /var/lib/grafana/dashboards

COPY nginx-api-dashboard.json /var/lib/grafana/dashboards/nginx-api-dashboard.json
COPY nginx-api-host-endpoint.json /var/lib/grafana/dashboards/nginx-api-host-endpoint.json
COPY nginx-api-host-endpoint-url.json /var/lib/grafana/dashboards/nginx-api-host-endpoint-url.json
COPY nginx-api-host.json /var/lib/grafana/dashboards/nginx-api-host.json


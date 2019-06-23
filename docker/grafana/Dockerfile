FROM grafana/grafana

COPY grafana.ini /etc/grafana/grafana.ini
COPY provisioning.yml /etc/grafana/provisioning/dashboards/provisioning.yml
COPY datasource.yml /etc/grafana/provisioning/datasources/datasource.yml

RUN mkdir /var/lib/grafana/dashboards

COPY api-dashboard.json /var/lib/grafana/dashboards/api-dashboard.json
COPY api-endpoint.json /var/lib/grafana/dashboards/api-endpoint.json
COPY api-endpoint-url.json /var/lib/grafana/dashboards/api-endpoint-url.json
COPY api-host.json /var/lib/grafana/dashboards/api-host.json

#COPY dashboard.json /var/lib/grafana/dashboards/dashboard.json
#COPY dashboard.json /etc/grafana/provisioning/dashboard.json

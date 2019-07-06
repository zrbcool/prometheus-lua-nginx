docker push zrbcool/prometheus-lua-grafana:latest
VERSION=$1
docker tag zrbcool/prometheus-lua-grafana:latest zrbcool/prometheus-lua-grafana:$VERSION
docker push zrbcool/prometheus-lua-grafana:$VERSION

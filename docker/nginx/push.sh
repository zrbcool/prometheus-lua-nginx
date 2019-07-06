docker push zrbcool/prometheus-lua-nginx:latest
VERSION=$1
docker tag zrbcool/prometheus-lua-nginx:latest zrbcool/prometheus-lua-nginx:$VERSION
docker push zrbcool/prometheus-lua-nginx:$VERSION

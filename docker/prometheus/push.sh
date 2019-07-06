COMPONENT="prom"
docker push zrbcool/prometheus-lua-$COMPONENT:latest
VERSION=$1
docker tag zrbcool/prometheus-lua-$COMPONENT:latest zrbcool/prometheus-lua-$COMPONENT:$VERSION
docker push zrbcool/prometheus-lua-$COMPONENT:$VERSION

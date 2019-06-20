## build open resty
cd ..
docker build -t prometheus-lua-nginx:latest -f docker/Dockerfile .

## build backend
cd backend
docker build -t prometheus-lua-backend:latest -f Dockerfile .


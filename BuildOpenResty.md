### Build OpenResty from source
```shell
su root
apt install libpcre3-dev libssl-dev perl make build-essential curl -y

export RESTY_HOME=/opt/openresty
mkdir -p $RESTY_HOME/build
cd $RESTY_HOME

# build openresty
wget https://openresty.org/download/openresty-1.13.6.2.tar.gz
tar -xvf openresty-1.13.6.2.tar.gz
cd openresty-1.13.6.2
./configure --prefix=$RESTY_HOME/build -j8
make -j8
make install
$RESTY_HOME/build/nginx/sbin/nginx -V
	nginx version: openresty/1.13.6.2
	built by gcc 8.3.0 (Ubuntu 8.3.0-6ubuntu1) 
	built with OpenSSL 1.1.1b  26 Feb 2019
	TLS SNI support enabled
	configure arguments: --prefix=/opt/openresty/build/nginx --with-cc-opt=-O2 ...  --with-http_ssl_module
$RESTY_HOME/build/nginx/sbin/nginx
curl localhost
	<html>
	...
	<p><em>Thank you for flying OpenResty.</em></p>
	...
	</html>
pkill nginx
```

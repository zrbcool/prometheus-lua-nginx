FROM ubuntu:18.04

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt-get update -y \
    && apt-get install wget -y \
    && apt-get install libpcre3-dev libssl-dev perl make build-essential curl -y 


RUN RESTY_HOME=/opt/openresty \
    && mkdir -p $RESTY_HOME/build \
    && wget https://openresty.org/download/openresty-1.13.6.2.tar.gz \
    && tar -xvf openresty-1.13.6.2.tar.gz \
    && cd openresty-1.13.6.2 \
    && ./configure --prefix=$RESTY_HOME/build -j8 \
    && make -j8 \
    && make install \
    && rm -f openresty-1.13.6.2.tar.gz \
    && rm -rf openresty-1.13.6.2

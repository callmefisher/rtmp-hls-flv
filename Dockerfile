#FROM mycujoo/nginx-http-flv-module
#RUN mkdir -p /data/hls && mkdir -p /data/dash
#COPY nginx.conf /opt/nginx/nginx.conf

FROM alpine:3.4
LABEL author Yanji Xia <xiayanjiji@gmail.com>

ENV NGINX_VERSION 1.1/3.9
ENV FFMPEG_VERSION 3.4.2

EXPOSE 1935
EXPOSE 80

RUN mkdir -p /opt/data && mkdir /www && mkdir -p /data/hls && mkdir -p /data/dash

# Build dependencies.
RUN	apk update && apk add	\
binutils \
binutils-libs \
build-base \
ca-certificates \
gcc \
libc-dev \
libgcc \
make \
musl-dev \
openssl \
openssl-dev \
pcre \
pcre-dev \
pkgconf \
pkgconfig \
zlib-dev

# Get nginx source.
RUN cd /tmp && \
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
tar zxf nginx-${NGINX_VERSION}.tar.gz && \
rm nginx-${NGINX_VERSION}.tar.gz

COPY . /tmp/nginx-http-flv-module

# Compile nginx with nginx-http-flv module.
RUN cd /tmp/nginx-${NGINX_VERSION} && \
./configure \
--prefix=/opt/nginx \
--add-module=/tmp/nginx-http-flv-module \
--conf-path=/opt/nginx/nginx.conf \
--error-log-path=/opt/nginx/logs/error.log \
--http-log-path=/opt/nginx/logs/access.log \
--with-debug && \
cd /tmp/nginx-${NGINX_VERSION} && make && make install


# Add NGINX config and static files.
ADD nginx.conf /opt/nginx/nginx.conf
ADD static /www/static

RUN mkdir -p /var/log/nginx \
&& ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["/opt/nginx/sbin/nginx"]

FROM mycujoo/nginx-http-flv-module
RUN mkdir -p /data/hls && mkdir -p /data/dash
COPY nginx.conf /opt/nginx/nginx.conf

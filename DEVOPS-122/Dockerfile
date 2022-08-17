########
# Dockerfile to build Nginx container images
# Based on Alpine
########


FROM nginx:1.23.0-alpine
LABEL version="1.0"

RUN apk update && apk upgrade && apk add curl


VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]


WORKDIR /usr/src/nginx_setup/
COPY . /usr/src/nginx_setup/


EXPOSE 80 90 8080 18080

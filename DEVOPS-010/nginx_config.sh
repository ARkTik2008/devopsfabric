#!/bin/bash
#
# This script makes changes to NGINX settings:
#   a) the default server shows HTTP 403 status code for all requests;
#   b) new virtual server named 'main.fabric' accepts requests on port 80/TCP,
#      - location /helloworld shows a static file,
#      - location /redirect redirects to corp site.
#
# Usage: sudo ./nginx_config.sh
#

set -e

# check for root
if [[ "$(id -u)" != "0" ]];then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# backuping existing default config
cp /etc/nginx/conf.d/default.conf{,.bak}

# replacing default config by new one
cp --force default.conf /etc/nginx/conf.d/default.conf

# adding new virtual server config
cp --force main.fabric.conf /etc/nginx/conf.d/main.fabric.conf

# checking && reloading NGINX config
nginx -t && nginx -s reload

# adding directiry for new virtual server
mkdir -p /var/www/main.fabric/html

# copiing index.html and hello.html
cp --force {index.html,hello.html} /var/www/main.fabric/html/

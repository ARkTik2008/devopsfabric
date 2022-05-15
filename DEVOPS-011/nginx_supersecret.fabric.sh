#!/bin/bash
#
# nginx_supersecret.fabric.sh
#
# This script add new virtual server 'supersecret.fabric' that:
#  - accepts requests on port 90/TCP,
#  - uses HTTP Basic Authentication,
#  - uses 'location /proxy' for proxy requests to daemon
#       `python3 -m http.server 8000`, running in the tmux,
#  - writes access.log in JSON format.
#
# Usage: sudo ./nginx_supersecret.fabric.sh
#

set -e

# check for root
if [[ "$(id -u)" != "0" ]];then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# adding new virtual server config and json logging config
cp --force {supersecret.fabric.conf,logging.conf} /etc/nginx/conf.d/

# checking && reloading NGINX config
nginx -t && nginx -s reload

# adding directiry for new virtual server
mkdir -p /var/www/supersecret.fabric/html

# copiing index.html and hello.html
cp --force {index.html,hello.html} /var/www/supersecret.fabric/html/

# copiing auth.basic file
cp --force auth.basic /etc/nginx/

# attaching or starting tmux session with python3 webserver
mkdir -p /var/www/supersecret.fabric/html/proxy/
cp --force hello.html /var/www/supersecret.fabric/html/proxy/
cd /var/www/supersecret.fabric/html/

# Tmux sets the TMUX environment variable in tmux session
if [ -z "$TMUX" ]; then
  tmux new-session -d -s python-server "python3 -m http.server 8000"
  tmux attach -t python-server
else
  tmux attach -t python-server
fi

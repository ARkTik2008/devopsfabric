#!/bin/bash
#
# This script creates 2 local docker volumes. Then, it copies nginx
#   'default.conf' and simple static site into appropriate directories.
#   Finaly, the script starts docker container with specified parameters.
#

set -e

docker volume create --name nginx_conf
docker volume create --name nginx_site
cp default.conf /var/lib/docker/volumes/nginx_conf/_data/
cp -a site/. /var/lib/docker/volumes/nginx_site/_data/

docker run \
    --detach \
    --name nginx \
    --publish 80:80 -p 8080:8080 -p 18080:18080 -p 90:90 \
    --restart=always \
    --volume nginx_conf:/etc/nginx/conf.d/:ro \
    --volume nginx_site:/usr/share/nginx/html/site/:ro \
    --memory=1g \
    --cpus=1 \
    nginx


# Get shell on a running container
# docker exec -it $(docker ps | grep nginx | awk '{print $1}') bash

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

# replacing default config
cat > /etc/nginx/conf.d/default.conf << EOF
server {
    listen      80 default_server;
    listen [::]:80 default_server;
    default_type "text/html";
    return 403;
}
EOF

# adding new virtual server config
cat >> /etc/nginx/conf.d/main.fabric.conf << EOF
# Virtual Host configuration for main.fabric
server {
       listen 80;
       listen [::]:80;
       server_name main.fabric;
       root /var/www/main.fabric/html;
       index index.html;
       location / {
               try_files $uri $uri/ =404;
       }
           location = /helloworld {
              try_files $uri /hello.html;
       }
           location = /redirect {
               return 302 https://fabric.baikalteam.com/;
       }
}
EOF

# reloading NGINX config
nginx -s reload

# adding directiry for new virtual server
mkdir -p /var/www/main.fabric/html

# adding new blanc files
cd /var/www/main.fabric/html
touch index.html hello.html

# adding content in index.html
cat > /var/www/main.fabric/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
<title>Welcome to main.fabric!</title>
<style>
  body {
    width: 35em;
    margin: 0 auto;
    font-family: Tahoma, Verdana, Arial, sans-serif;
  }
</style>
</head>
<body>
<h1>Welcome to main.fabric!</h1>
<p>If you see this page, the main.fabric web server is successfully installed and
working. Further configuration is required.</p>
<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>
<p><em>Thank you for using nginx.</em></p>
</body>
</html>
EOF

# adding content in hello.html
cat > /var/www/main.fabric/html/hello.html << EOF
<!DOCTYPE html>
<html>
<head>
<title>Welcome to helloworld page!</title>
<style>
  body {
    width: 35em;
    margin: 0 auto;
    font-family: Tahoma, Verdana, Arial, sans-serif;
  }
</style>
</head>
<body>
<h1>Welcome to helloworld page!</h1>
<p>If you see this page, the main.fabric web server is successfully installed and
working. Further configuration is required.</p>
<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>
<p><em>Thank you for using nginx.</em></p>
</body>
</html>
EOF

# adding new virtual host in /etc/hosts
cat >> /etc/hosts << EOF
`ip route get 1 | awk '{print $7}'` main.fabric
EOF



# validating default server by IP
curl -Ik http://192.168.88.111:80
# output
: '
HTTP/1.1 403 Forbidden
Server: nginx/1.20.1
Date: Thu, 12 May 2022 20:26:09 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
'


# validating default server by local IP
curl -Ik http://127.0.0.1:80
# output
: '
HTTP/1.1 403 Forbidden
Server: nginx/1.20.1
Date: Thu, 12 May 2022 20:30:42 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
'


# validating default server by local domain
curl -Ik http://localhost:80
# output
: '
HTTP/1.1 403 Forbidden
Server: nginx/1.20.1
Date: Thu, 12 May 2022 20:23:30 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
'


# validating host main.fabric:80
curl -Ik http://main.fabric:80
# output
: '
HTTP/1.1 200 OK
Server: nginx/1.20.1
Date: Thu, 12 May 2022 20:22:24 GMT
Content-Type: text/html
Content-Length: 628
Last-Modified: Thu, 12 May 2022 12:11:37 GMT
Connection: keep-alive
ETag: "627cf979-274"
Accept-Ranges: bytes
'


# validating location /helloworld
curl -Ik http://main.fabric/helloworld
# output
: '
HTTP/1.1 200 OK
Server: nginx/1.20.1
Date: Thu, 12 May 2022 20:16:26 GMT
Content-Type: text/html
Content-Length: 636
Last-Modified: Thu, 12 May 2022 12:13:53 GMT
Connection: keep-alive
ETag: "627cfa01-27c"
Accept-Ranges: bytes
'


# validating location /redirect
curl -Ik http://main.fabric/redirect
# output
: '
HTTP/1.1 302 Moved Temporarily
Server: nginx/1.20.1
Date: Thu, 12 May 2022 20:21:04 GMT
Content-Type: text/html
Content-Length: 145
Connection: keep-alive
Location: https://fabric.baikalteam.com/
'

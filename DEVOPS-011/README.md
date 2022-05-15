# DEVOPS-011 extra nginx configuration

### curl -Ik http://bob:4228@192.168.88.111:90
```
HTTP/1.1 200 OK
Server: nginx/1.20.1
Date: Sat, 14 May 2022 18:45:12 GMT
Content-Type: text/html
Content-Length: 649
Last-Modified: Fri, 13 May 2022 20:04:33 GMT
Connection: keep-alive
ETag: "627eb9d1-289"
Accept-Ranges: bytes
```


### curl -Ik http://192.168.88.111:90
```
HTTP/1.1 401 Unauthorized
Server: nginx/1.20.1
Date: Sat, 14 May 2022 18:45:38 GMT
Content-Type: text/html
Content-Length: 179
Connection: keep-alive
WWW-Authenticate: Basic realm="Restricted area"
```


### curl -Ik --resolve supersecret.fabric:90:192.168.88.111 http://supersecret.fabric:90
```
HTTP/1.1 401 Unauthorized
Server: nginx/1.20.1
Date: Sat, 14 May 2022 18:46:29 GMT
Content-Type: text/html
Content-Length: 179
Connection: keep-alive
WWW-Authenticate: Basic realm="Restricted area"
```


### curl -Ik --resolve supersecret.fabric:90:192.168.88.111 http://snoop:4228@supersecret.fabric:90
```
HTTP/1.1 200 OK
Server: nginx/1.20.1
Date: Sat, 14 May 2022 18:46:45 GMT
Content-Type: text/html
Content-Length: 649
Last-Modified: Fri, 13 May 2022 20:04:33 GMT
Connection: keep-alive
ETag: "627eb9d1-289"
Accept-Ranges: bytes
```


### curl -Ik --resolve supersecret.fabric:90:192.168.88.111 http://snoop:4228@supersecret.fabric:90/proxy
```
HTTP/1.1 301 Moved Permanently
Server: nginx/1.20.1
Date: Sat, 14 May 2022 18:47:03 GMT
Connection: keep-alive
Location: /proxy/
```


### sudo nginx -T
```
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
# configuration file /etc/nginx/nginx.conf:

user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;
}

# configuration file /etc/nginx/mime.types:

types {
    text/html                                        html htm shtml;
    text/css                                         css;
    text/xml                                         xml;
    image/gif                                        gif;
    image/jpeg                                       jpeg jpg;
    application/javascript                           js;
    application/atom+xml                             atom;
    application/rss+xml                              rss;

    text/mathml                                      mml;
    text/plain                                       txt;
    text/vnd.sun.j2me.app-descriptor                 jad;
    text/vnd.wap.wml                                 wml;
    text/x-component                                 htc;

    image/png                                        png;
    image/svg+xml                                    svg svgz;
    image/tiff                                       tif tiff;
    image/vnd.wap.wbmp                               wbmp;
    image/webp                                       webp;
    image/x-icon                                     ico;
    image/x-jng                                      jng;
    image/x-ms-bmp                                   bmp;

    font/woff                                        woff;
    font/woff2                                       woff2;

    application/java-archive                         jar war ear;
    application/json                                 json;
    application/mac-binhex40                         hqx;
    application/msword                               doc;
    application/pdf                                  pdf;
    application/postscript                           ps eps ai;
    application/rtf                                  rtf;
    application/vnd.apple.mpegurl                    m3u8;
    application/vnd.google-earth.kml+xml             kml;
    application/vnd.google-earth.kmz                 kmz;
    application/vnd.ms-excel                         xls;
    application/vnd.ms-fontobject                    eot;
    application/vnd.ms-powerpoint                    ppt;
    application/vnd.oasis.opendocument.graphics      odg;
    application/vnd.oasis.opendocument.presentation  odp;
    application/vnd.oasis.opendocument.spreadsheet   ods;
    application/vnd.oasis.opendocument.text          odt;
    application/vnd.openxmlformats-officedocument.presentationml.presentation
                                                     pptx;
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
                                                     xlsx;
    application/vnd.openxmlformats-officedocument.wordprocessingml.document
                                                     docx;
    application/vnd.wap.wmlc                         wmlc;
    application/x-7z-compressed                      7z;
    application/x-cocoa                              cco;
    application/x-java-archive-diff                  jardiff;
    application/x-java-jnlp-file                     jnlp;
    application/x-makeself                           run;
    application/x-perl                               pl pm;
    application/x-pilot                              prc pdb;
    application/x-rar-compressed                     rar;
    application/x-redhat-package-manager             rpm;
    application/x-sea                                sea;
    application/x-shockwave-flash                    swf;
    application/x-stuffit                            sit;
    application/x-tcl                                tcl tk;
    application/x-x509-ca-cert                       der pem crt;
    application/x-xpinstall                          xpi;
    application/xhtml+xml                            xhtml;
    application/xspf+xml                             xspf;
    application/zip                                  zip;

    application/octet-stream                         bin exe dll;
    application/octet-stream                         deb;
    application/octet-stream                         dmg;
    application/octet-stream                         iso img;
    application/octet-stream                         msi msp msm;

    audio/midi                                       mid midi kar;
    audio/mpeg                                       mp3;
    audio/ogg                                        ogg;
    audio/x-m4a                                      m4a;
    audio/x-realaudio                                ra;

    video/3gpp                                       3gpp 3gp;
    video/mp2t                                       ts;
    video/mp4                                        mp4;
    video/mpeg                                       mpeg mpg;
    video/quicktime                                  mov;
    video/webm                                       webm;
    video/x-flv                                      flv;
    video/x-m4v                                      m4v;
    video/x-mng                                      mng;
    video/x-ms-asf                                   asx asf;
    video/x-ms-wmv                                   wmv;
    video/x-msvideo                                  avi;
}

# configuration file /etc/nginx/conf.d/default.conf:
server {
    listen      80 default_server;
    listen [::]:80 default_server;
    default_type "text/html";
    return 403;
}


# configuration file /etc/nginx/conf.d/logging.conf:
log_format main_json escape=json '{'
  '"msec": "$msec", ' # request unixtime in seconds with a milliseconds resolution
  '"connection": "$connection", ' # connection serial number
  '"connection_requests": "$connection_requests", ' # number of requests made in connection
  '"pid": "$pid", ' # process pid
  '"request_id": "$request_id", ' # the unique request id
  '"request_length": "$request_length", ' # request length (including headers and body)
  '"remote_addr": "$remote_addr", ' # client IP
  '"remote_user": "$remote_user", ' # client HTTP username
  '"remote_port": "$remote_port", ' # client port
  '"time_local": "$time_local", '
  '"time_iso8601": "$time_iso8601", ' # local time in the ISO 8601 standard format
  '"request": "$request", ' # full path no arguments if the request
  '"request_uri": "$request_uri", ' # full path and arguments if the request
  '"args": "$args", ' # args
  '"status": "$status", ' # response status code
  '"body_bytes_sent": "$body_bytes_sent", ' # the number of body bytes exclude headers sent to a client
  '"bytes_sent": "$bytes_sent", ' # the number of bytes sent to a client
  '"http_referer": "$http_referer", ' # HTTP referer
  '"http_user_agent": "$http_user_agent", ' # user agent
  '"http_x_forwarded_for": "$http_x_forwarded_for", ' # http_x_forwarded_for
  '"http_host": "$http_host", ' # the request Host: header
  '"server_name": "$server_name", ' # the name of the vhost serving the request
  '"request_time": "$request_time", ' # request processing time in seconds with msec resolution
  '"upstream": "$upstream_addr", ' # upstream backend server for proxied requests
  '"upstream_connect_time": "$upstream_connect_time", ' # upstream handshake time incl. TLS
  '"upstream_header_time": "$upstream_header_time", ' # time spent receiving upstream headers
  '"upstream_response_time": "$upstream_response_time", ' # time spend receiving upstream body
  '"upstream_response_length": "$upstream_response_length", ' # upstream response length
  '"upstream_cache_status": "$upstream_cache_status", ' # cache HIT/MISS where applicable
  '"ssl_protocol": "$ssl_protocol", ' # TLS protocol
  '"ssl_cipher": "$ssl_cipher", ' # TLS cipher
  '"scheme": "$scheme", ' # http or https
  '"request_method": "$request_method", ' # request method
  '"server_protocol": "$server_protocol", ' # request protocol, like HTTP/1.1 or HTTP/2.0
  '"pipe": "$pipe", ' # “p” if request was pipelined, “.” otherwise
  '"gzip_ratio": "$gzip_ratio", '
  '"http_cf_ray": "$http_cf_ray"'
'}';
# configuration file /etc/nginx/conf.d/main.fabric.conf:
#
# Virtual Host configuration for main.fabric
#
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


# configuration file /etc/nginx/conf.d/supersecret.fabric.conf:
# Virtual Host configuration for supersecret.fabric.conf
server {
       listen 90;
       listen [::]:90;
       server_name supersecret.fabric;
       root /var/www/supersecret.fabric/html;
       index index.html;
       access_log /var/log/nginx/supersecret.fabric-access_log.json main_json;
       error_log /var/log/nginx/supersecret.fabric-error.log;
       auth_basic "Restricted area";
       auth_basic_user_file /etc/nginx/auth.basic;

       location / {
            try_files $uri $uri/ =404;
       }

       location /proxy {
            proxy_pass http://127.0.0.1:8000;
#            proxy_set_header Host $http_host;
#            proxy_set_header X-Script-Name /proxy;
       }
}
```

### Access log in JSON format
```
{"msec": "1652554222.642", "connection": "309", "connection_requests": "2", "pid": "35815", "request_id": "3796df987ea6abde6e46da37cfce6f80", "request_length": "321", "remote_addr": "192.168.88.149", "remote_user": "bob", "remote_port": "20237", "time_local": "14/May/2022:18:50:22 +0000", "time_iso8601": "2022-05-14T18:50:22+00:00", "request": "GET / HTTP/1.1", "request_uri": "/", "args": "", "status": "200", "body_bytes_sent": "649", "bytes_sent": "887", "http_referer": "", "http_user_agent": "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko", "http_x_forwarded_for": "", "http_host": "supersecret.fabric:90", "server_name": "supersecret.fabric", "request_time": "0.000", "upstream": "", "upstream_connect_time": "", "upstream_header_time": "", "upstream_response_time": "", "upstream_response_length": "", "upstream_cache_status": "", "ssl_protocol": "", "ssl_cipher": "", "scheme": "http", "request_method": "GET", "server_protocol": "HTTP/1.1", "pipe": ".", "gzip_ratio": "", "http_cf_ray": ""}
{"msec": "1652554222.686", "connection": "310", "connection_requests": "1", "pid": "35815", "request_id": "18d2c7fd7e3c247a2ba69032e4c6569f", "request_length": "230", "remote_addr": "192.168.88.149", "remote_user": "", "remote_port": "20238", "time_local": "14/May/2022:18:50:22 +0000", "time_iso8601": "2022-05-14T18:50:22+00:00", "request": "GET /favicon.ico HTTP/1.1", "request_uri": "/favicon.ico", "args": "", "status": "401", "body_bytes_sent": "179", "bytes_sent": "386", "http_referer": "", "http_user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; Trident/7.0; rv:11.0) like Gecko", "http_x_forwarded_for": "", "http_host": "supersecret.fabric:90", "server_name": "supersecret.fabric", "request_time": "0.000", "upstream": "", "upstream_connect_time": "", "upstream_header_time": "", "upstream_response_time": "", "upstream_response_length": "", "upstream_cache_status": "", "ssl_protocol": "", "ssl_cipher": "", "scheme": "http", "request_method": "GET", "server_protocol": "HTTP/1.1", "pipe": ".", "gzip_ratio": "", "http_cf_ray": ""}
{"msec": "1652554234.264", "connection": "309", "connection_requests": "3", "pid": "35815", "request_id": "006e0b12bc5ef4c3b48e153de5a71510", "request_length": "326", "remote_addr": "192.168.88.149", "remote_user": "bob", "remote_port": "20237", "time_local": "14/May/2022:18:50:34 +0000", "time_iso8601": "2022-05-14T18:50:34+00:00", "request": "GET /proxy HTTP/1.1", "request_uri": "/proxy", "args": "", "status": "301", "body_bytes_sent": "5", "bytes_sent": "169", "http_referer": "", "http_user_agent": "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko", "http_x_forwarded_for": "", "http_host": "supersecret.fabric:90", "server_name": "supersecret.fabric", "request_time": "0.001", "upstream": "127.0.0.1:8000", "upstream_connect_time": "0.000", "upstream_header_time": "0.000", "upstream_response_time": "0.000", "upstream_response_length": "0", "upstream_cache_status": "", "ssl_protocol": "", "ssl_cipher": "", "scheme": "http", "request_method": "GET", "server_protocol": "HTTP/1.1", "pipe": ".", "gzip_ratio": "", "http_cf_ray": ""}
{"msec": "1652554234.266", "connection": "309", "connection_requests": "4", "pid": "35815", "request_id": "f531da687cc73e377e536fed1a5848a4", "request_length": "327", "remote_addr": "192.168.88.149", "remote_user": "bob", "remote_port": "20237", "time_local": "14/May/2022:18:50:34 +0000", "time_iso8601": "2022-05-14T18:50:34+00:00", "request": "GET /proxy/ HTTP/1.1", "request_uri": "/proxy/", "args": "", "status": "200", "body_bytes_sent": "354", "bytes_sent": "517", "http_referer": "", "http_user_agent": "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko", "http_x_forwarded_for": "", "http_host": "supersecret.fabric:90", "server_name": "supersecret.fabric", "request_time": "0.001", "upstream": "127.0.0.1:8000", "upstream_connect_time": "0.000", "upstream_header_time": "0.000", "upstream_response_time": "0.000", "upstream_response_length": "354", "upstream_cache_status": "", "ssl_protocol": "", "ssl_cipher": "", "scheme": "http", "request_method": "GET", "server_protocol": "HTTP/1.1", "pipe": ".", "gzip_ratio": "", "http_cf_ray": ""}
{"msec": "1652554234.293", "connection": "310", "connection_requests": "2", "pid": "35815", "request_id": "2e0afce4744d7baf62c4092bb8455bc8", "request_length": "230", "remote_addr": "192.168.88.149", "remote_user": "", "remote_port": "20238", "time_local": "14/May/2022:18:50:34 +0000", "time_iso8601": "2022-05-14T18:50:34+00:00", "request": "GET /favicon.ico HTTP/1.1", "request_uri": "/favicon.ico", "args": "", "status": "401", "body_bytes_sent": "179", "bytes_sent": "386", "http_referer": "", "http_user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; Trident/7.0; rv:11.0) like Gecko", "http_x_forwarded_for": "", "http_host": "supersecret.fabric:90", "server_name": "supersecret.fabric", "request_time": "0.000", "upstream": "", "upstream_connect_time": "", "upstream_header_time": "", "upstream_response_time": "", "upstream_response_length": "", "upstream_cache_status": "", "ssl_protocol": "", "ssl_cipher": "", "scheme": "http", "request_method": "GET", "server_protocol": "HTTP/1.1", "pipe": ".", "gzip_ratio": "", "http_cf_ray": ""}
```

---


## Screenshots

![NGINX vhost proxy_pass IP](/DEVOPS-011/IP+proxy.png)

![NGINX vhost proxy_pass Domain](/DEVOPS-011/domain+proxy.png)

![TMUX session](/DEVOPS-011/tmux.png)
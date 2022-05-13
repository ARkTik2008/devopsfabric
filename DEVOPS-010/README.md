# DEVOPS-010 basic nginx configuration

### 1. validating default server by local IP
**`curl -Ik 192.168.88.111:80`**

```
HTTP/1.1 403 Forbidden
Server: nginx/1.20.1
Date: Fri, 13 May 2022 07:44:49 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
```


### 2. validating default server by loopback IP
**`curl -Ik http://127.0.0.1:80`**

```
HTTP/1.1 403 Forbidden
Server: nginx/1.20.1
Date: Fri, 13 May 2022 07:45:48 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
```


### 3. validating default server by local domain
**`curl -Ik http://localhost:80`**

```
HTTP/1.1 403 Forbidden
Server: nginx/1.20.1
Date: Fri, 13 May 2022 07:47:29 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
```


### 4. validating host main.fabric:80
**`curl -Ik http://main.fabric:80`**
```
curl: (6) Could not resolve host: main.fabric
```

**`curl -Ik --resolve main.fabric:80:192.168.88.111 http://main.fabric`**
```
HTTP/1.1 200 OK
Server: nginx/1.20.1
Date: Fri, 13 May 2022 07:48:21 GMT
Content-Type: text/html
Content-Length: 628
Last-Modified: Thu, 12 May 2022 12:11:37 GMT
Connection: keep-alive
ETag: "627cf979-274"
Accept-Ranges: bytes
```


### 5. validating location /helloworld
**`curl -Ik http://main.fabric/helloworld`**
```
curl: (6) Could not resolve host: main.fabric
```

**`curl -Ik --resolve main.fabric:80:192.168.88.111 http://main.fabric/helloworld`**
```
HTTP/1.1 200 OK
Server: nginx/1.20.1
Date: Fri, 13 May 2022 07:49:27 GMT
Content-Type: text/html
Content-Length: 636
Last-Modified: Thu, 12 May 2022 12:13:53 GMT
Connection: keep-alive
ETag: "627cfa01-27c"
Accept-Ranges: bytes
```


### 6. validating location /redirect
**`curl -Ik http://main.fabric/redirect`**
```
curl: (6) Could not resolve host: main.fabric
```

**`curl -Ik --resolve main.fabric:80:192.168.88.111 http://main.fabric/redirect`**
```
HTTP/1.1 302 Moved Temporarily
Server: nginx/1.20.1
Date: Fri, 13 May 2022 07:50:24 GMT
Content-Type: text/html
Content-Length: 145
Connection: keep-alive
Location: https://fabric.baikalteam.com/
```


### 7. validating non-existent URI
**`curl -Ik http://main.fabric/hello`**
```
curl: (6) Could not resolve host: main.fabric
```

**`curl -Ik --resolve main.fabric:80:192.168.88.111 http://main.fabric/hello`**
```
HTTP/1.1 404 Not Found
Server: nginx/1.20.1
Date: Fri, 13 May 2022 09:13:29 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
```


---

## Screenshots

![NGINX config validation](/DEVOPS-010/validation.png)
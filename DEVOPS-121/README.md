# DEVOPS-121 Docker intro

[docker_starter.sh](/DEVOPS-121/docker_starter.sh) - script that creates 2 local docker volumes, copies nginx 'default.conf' and simple static site into appropriate directories, and starts docker container with specified parameters.

## Task validation

## On VM with running docker container

**`hostname -I | cut -d' ' -f1`**
```bash
192.168.88.107
```


**`docker ps`**
```bash
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                                                                                                                                            NAMES
9ab39f7c78e4   nginx     "/docker-entrypoint.…"   18 minutes ago   Up 18 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp, 0.0.0.0:90->90/tcp, :::90->90/tcp, 0.0.0.0:8080->8080/tcp, :::8080->8080/tcp, 0.0.0.0:18080->18080/tcp, :::18080->18080/tcp   nginx
```


**`sudo lsof -i -P | grep docker`**
```bash
docker-pr 282722            root    4u  IPv4 726354      0t0  TCP *:18080 (LISTEN)
docker-pr 282729            root    4u  IPv6 726359      0t0  TCP *:18080 (LISTEN)
docker-pr 282741            root    4u  IPv4 726392      0t0  TCP *:8080 (LISTEN)
docker-pr 282746            root    4u  IPv6 726397      0t0  TCP *:8080 (LISTEN)
docker-pr 282760            root    4u  IPv4 727157      0t0  TCP *:90 (LISTEN)
docker-pr 282765            root    4u  IPv6 726431      0t0  TCP *:90 (LISTEN)
docker-pr 282780            root    4u  IPv4 727177      0t0  TCP *:80 (LISTEN)
docker-pr 282785            root    4u  IPv6 726469      0t0  TCP *:80 (LISTEN)
```


**`curl 192.168.88.107/nginx_status`**
```bash
Active connections: 1
server accepts handled requests
 21 21 46
Reading: 0 Writing: 1 Waiting: 0
```


## On neighboring VM (check if nginx_status available from non-parental host)

**`hostname -I | cut -d' ' -f1`**
```bash
192.168.88.111
```


**`curl -Ik 192.168.88.107/nginx_status`**
```bash
HTTP/1.1 403 Forbidden
Server: nginx/1.23.0
Date: Fri, 08 Jul 2022 11:43:54 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
```


## Validation in the browser

### Static site openned as domain
![example.com](/DEVOPS-121/example.com.png)

### Static site as openned IP address
![192.168.88.107](/DEVOPS-121/192.168.88.107.png)

### Show hostname
![192.168.88.107/hostname](/DEVOPS-121/192.168.88.107_hostname.png)

### Check if nginx_status available from non-parental host
![192.168.88.107/nginx_status](/DEVOPS-121/192.168.88.107_nginx_status.png)

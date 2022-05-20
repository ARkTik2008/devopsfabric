# DEVOPS-052 basic ufw configuration

## List of files:
1. **ufw_config.sh** - main script in the task, configures UFW rules.
2. **ufw_reset.sh** - script-helper, disables UFW or reboots host.
3. **countdown.sh** - optional countdown script for script-helper.
4. **README.md**   - this document, validations and comments.

####
---
####

## Set UFW rules to run at system startup

The command `ufw --force enable` just enables UFW on system startup.



## Validating the task
1. ### From host itself

```console
hostname -I
192.168.88.111 172.17.0.1
```

**`ping 192.168.88.1`**
```
PING 192.168.88.1 (192.168.88.1) 56(84) bytes of data.
64 bytes from 192.168.88.1: icmp_seq=1 ttl=64 time=0.403 ms
64 bytes from 192.168.88.1: icmp_seq=2 ttl=64 time=0.349 ms
64 bytes from 192.168.88.1: icmp_seq=3 ttl=64 time=0.374 ms
^C
--- 192.168.88.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2055ms
rtt min/avg/max/mdev = 0.349/0.375/0.403/0.022 ms
```

**`ping 8.8.8.8`**
```
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=107 time=33.4 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=107 time=33.3 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=107 time=33.4 ms
^C
--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 33.283/33.340/33.373/0.040 ms
```

**`ping google.so`**
```
PING forcesafesearch.google.com (216.239.38.120) 56(84) bytes of data.
64 bytes from any-in-2678.1e100.net (216.239.38.120): icmp_seq=1 ttl=104 time=35.1 ms
64 bytes from any-in-2678.1e100.net (216.239.38.120): icmp_seq=2 ttl=104 time=35.0 ms
64 bytes from any-in-2678.1e100.net (216.239.38.120): icmp_seq=3 ttl=104 time=34.9 ms
^C
--- forcesafesearch.google.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 34.878/34.994/35.111/0.095 ms
```

**`curl -Ik https://vk.com`**
```
HTTP/2 418
server: kittenx
date: Fri, 20 May 2022 12:30:51 GMT
content-length: 0
x-frontend: front226206
access-control-expose-headers: X-Frontend
alt-svc: h3=":443"; ma=86400,h3-29=":443"; ma=86400
```

**`curl -Ik https://ya.ru`**
```console
HTTP/1.1 200 Ok
Accept-CH: Viewport-Width, DPR, Device-Memory, RTT, Downlink, ECT
Accept-CH-Lifetime: 31536000
Cache-Control: no-cache,no-store,max-age=0,must-revalidate
Content-Length: 60500
<...>
```


2. ### From other host in same local network

```console
hostname -I
192.168.88.108 172.17.0.1
```

**`ping 192.168.88.111`**
```
PING 192.168.88.111 (192.168.88.111) 56(84) bytes of data.
64 bytes from 192.168.88.111: icmp_seq=1 ttl=64 time=0.190 ms
64 bytes from 192.168.88.111: icmp_seq=2 ttl=64 time=0.270 ms
64 bytes from 192.168.88.111: icmp_seq=3 ttl=64 time=0.269 ms
^C
--- 192.168.88.111 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2034ms
rtt min/avg/max/mdev = 0.190/0.243/0.270/0.037 ms
```

**`curl -Ik 192.168.88.111:80`**
```
HTTP/1.1 403 Forbidden
Server: nginx/1.20.1
Date: Fri, 20 May 2022 12:35:42 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
```

**`telnet 192.168.88.111 80`**
```
Trying 192.168.88.111...
Connected to 192.168.88.111.
Escape character is '^]'.
```

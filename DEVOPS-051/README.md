# DEVOPS-051 basic iptables configuration

## List of files:
1. **iptables_config.sh** - main script in the task, configures iptables rules.
2. **fw_reset.sh** - script-helper, returns iptables to previous settings or reboots host.
3. **countdown.sh** - optional script for script-helper.
4. **README.md**   - this document, validations and comments.

####
---
####

## Validating the task
1. ### From host itself

```console
hostname -I
192.168.88.111 172.17.0.1
```

**`ping 192.168.88.1`**
```
PING 192.168.88.1 (192.168.88.1) 56(84) bytes of data.
64 bytes from 192.168.88.1: icmp_seq=1 ttl=64 time=0.461 ms
64 bytes from 192.168.88.1: icmp_seq=2 ttl=64 time=0.358 ms
64 bytes from 192.168.88.1: icmp_seq=3 ttl=64 time=0.350 ms
^C
--- 192.168.88.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2048ms
rtt min/avg/max/mdev = 0.350/0.389/0.461/0.050 ms
```

**`ping 8.8.8.8`**
```
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=108 time=32.9 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=108 time=32.7 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=108 time=32.9 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=108 time=32.9 ms
^C
--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3006ms
rtt min/avg/max/mdev = 32.692/32.824/32.896/0.078 ms
```

**`ping google.us`**
```
PING google.us (74.125.131.104) 56(84) bytes of data.
64 bytes from lu-in-f104.1e100.net (74.125.131.104): icmp_seq=1 ttl=60 time=46.7 ms
64 bytes from lu-in-f104.1e100.net (74.125.131.104): icmp_seq=2 ttl=60 time=46.4 ms
64 bytes from lu-in-f104.1e100.net (74.125.131.104): icmp_seq=3 ttl=60 time=46.5 ms
^C
--- google.us ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 46.402/46.520/46.680/0.117 ms
```

**`curl -Ik http://wttr.in`**
```
HTTP/1.1 200 OK
Server: nginx/1.10.3
Date: Thu, 19 May 2022 12:10:38 GMT
Content-Type: text/plain; charset=utf-8
Content-Length: 9169
Connection: keep-alive
Access-Control-Allow-Origin: *
```

**`curl -Ik https://ya.ru`**
```console
HTTP/1.1 200 Ok
Accept-CH: Viewport-Width, DPR, Device-Memory, RTT, Downlink, ECT
Accept-CH-Lifetime: 31536000
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
64 bytes from 192.168.88.111: icmp_seq=1 ttl=64 time=0.265 ms
64 bytes from 192.168.88.111: icmp_seq=2 ttl=64 time=0.281 ms
64 bytes from 192.168.88.111: icmp_seq=3 ttl=64 time=0.303 ms
^C
--- 192.168.88.111 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2028ms
rtt min/avg/max/mdev = 0.265/0.283/0.303/0.015 ms
```

**`curl -Ik 192.168.88.111:80`**
```
HTTP/1.1 403 Forbidden
Server: nginx/1.20.1
Date: Thu, 19 May 2022 11:11:08 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
```

**`telnet 192.168.88.111 80`**
```
Trying 192.168.88.111...
Connected to 192.168.88.111.
Escape character is '^]'.
Connection closed by foreign host.
```

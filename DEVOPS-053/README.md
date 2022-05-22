# DEVOPS-053 routing exercise

## L3 logical network diagram

![L3 logical network diagram](/DEVOPS-053/network_diagram.png)


### **Hosts:**
1. Working Host (WIndows 10 non-virtualized).
2. Main testing host (Ubuntu 20.04 virtualized).
3. Additional testing host (Ubuntu 20.04 virtualized).


### **Subnets:**
1. 192.168.88.0/24.
2. 172.31.255.0/25.
3. 10.10.10.0/26.


---


## **Set static routing**
### **1. On host1**
We need to add static route to the third subnet only:
```console
route add 10.10.10.0 mask 255.255.255.192 172.31.255.2
```

### **2. On host2**
2.1. Enable new network interface and add static IP:
```console
ip link set eth1 up
ip a add 172.31.255.111/25 dev eth1
```
2.2. Set static route to the third subnet via eth1:
```console
ip route add 10.10.10.0/26 via 172.31.255.111 dev eth1
```

### **3. On host3**
3.1. Disable network interface with DHCP-pulled IP: 
```console
ip link set eth0 down
```
3.2. Enable new network interface eth1 and add static IP:
```console
ip link set eth1 up
ip a add 172.31.255.2/25 dev eth1
```
3.3. Enable new network interface eth2 and add static IP:
```console
ip link set eth2 up
ip a add 10.10.10.2/26 dev eth2
```
3.4. Set static route to the first subnet via eth1:
```console
ip route add 192.168.88.0/24 via 172.31.255.111 dev eth1
```


## **Validating the task**
### **1. Network connectivity from host1 to eth2 host3**

**`ping 10.10.10.2`**
```
Обмен пакетами с 10.10.10.2 по с 32 байтами данных:
Ответ от 10.10.10.2: число байт=32 время<1мс TTL=63
Ответ от 10.10.10.2: число байт=32 время<1мс TTL=63
Ответ от 10.10.10.2: число байт=32 время<1мс TTL=63
Ответ от 10.10.10.2: число байт=32 время<1мс TTL=63

Статистика Ping для 10.10.10.2:
    Пакетов: отправлено = 4, получено = 4, потеряно = 0
    (0% потерь)
Приблизительное время приема-передачи в мс:
    Минимальное = 0мсек, Максимальное = 0 мсек, Среднее = 0 мсек
```

### **2. Network connectivity from host3 to eth0 host2**
**`ping 192.168.88.111`**
```
PING 192.168.88.111 (192.168.88.111) 56(84) bytes of data.
64 bytes from 192.168.88.111: icmp_seq=1 ttl=64 time=0.030 ms
64 bytes from 192.168.88.111: icmp_seq=2 ttl=64 time=0.032 ms
64 bytes from 192.168.88.111: icmp_seq=3 ttl=64 time=0.022 ms
^C
--- 192.168.88.111 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2052ms
rtt min/avg/max/mdev = 0.022/0.028/0.032/0.004 ms
```

### **3. Curl from host3 to nginx host2**
**`curl -Ik 192.168.88.111:80`**

```
HTTP/1.1 403 Forbidden
Server: nginx/1.20.1
Date: Sun, 22 May 2022 16:20:28 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
```

### **4. IP routing table on host1**

**`route print`**

```
===========================================================================
Список интерфейсов
 26...........................Wintun Userspace Tunnel
 27...........................Windscribe Windtun420
 15...00 ff 67 21 a2 e8 ......TAP-Windows Adapter V9
 16...00 ff 69 fe 35 e1 ......Windscribe VPN
 22...18 c0 4d da a6 33 ......Hyper-V Virtual Ethernet Adapter
 19...00 1a 7d da 71 11 ......Bluetooth Device (Personal Area Network)
  1...........................Software Loopback Interface 1
 48...00 15 5d a0 38 d7 ......Hyper-V Virtual Ethernet Adapter #2
 55...00 15 5d 80 a8 7b ......Hyper-V Virtual Ethernet Adapter #3
 63...00 15 5d 60 1e 16 ......Hyper-V Virtual Ethernet Adapter #4
===========================================================================

IPv4 таблица маршрута
===========================================================================
Активные маршруты:
Сетевой адрес           Маска сети      Адрес шлюза       Интерфейс  Метрика
          0.0.0.0          0.0.0.0     192.168.88.1   192.168.88.149     35
       10.10.10.0  255.255.255.192   192.168.88.111   192.168.88.149     36
        127.0.0.0        255.0.0.0         On-link         127.0.0.1    331
        127.0.0.1  255.255.255.255         On-link         127.0.0.1    331
  127.255.255.255  255.255.255.255         On-link         127.0.0.1    331
      172.17.96.0    255.255.240.0         On-link       172.17.96.1   5256
      172.17.96.1  255.255.255.255         On-link       172.17.96.1   5256
   172.17.111.255  255.255.255.255         On-link       172.17.96.1   5256
     172.18.112.0    255.255.240.0         On-link      172.18.112.1   5256
     172.18.112.1  255.255.255.255         On-link      172.18.112.1   5256
   172.18.127.255  255.255.255.255         On-link      172.18.112.1   5256
     172.29.160.0    255.255.240.0         On-link      172.29.160.1   5256
     172.29.160.1  255.255.255.255         On-link      172.29.160.1   5256
   172.29.175.255  255.255.255.255         On-link      172.29.160.1   5256
     192.168.88.0    255.255.255.0         On-link    192.168.88.149    291
   192.168.88.149  255.255.255.255         On-link    192.168.88.149    291
   192.168.88.255  255.255.255.255         On-link    192.168.88.149    291
        224.0.0.0        240.0.0.0         On-link         127.0.0.1    331
        224.0.0.0        240.0.0.0         On-link    192.168.88.149    291
        224.0.0.0        240.0.0.0         On-link       172.17.96.1   5256
        224.0.0.0        240.0.0.0         On-link      172.18.112.1   5256
        224.0.0.0        240.0.0.0         On-link      172.29.160.1   5256
  255.255.255.255  255.255.255.255         On-link         127.0.0.1    331
  255.255.255.255  255.255.255.255         On-link    192.168.88.149    291
  255.255.255.255  255.255.255.255         On-link       172.17.96.1   5256
  255.255.255.255  255.255.255.255         On-link      172.18.112.1   5256
  255.255.255.255  255.255.255.255         On-link      172.29.160.1   5256
===========================================================================
Постоянные маршруты:
  Отсутствует

IPv6 таблица маршрута
===========================================================================
Активные маршруты:
 Метрика   Сетевой адрес            Шлюз
  1    331 ::1/128                  On-link
 48   5256 fe80::/64                On-link
 55   5256 fe80::/64                On-link
 63   5256 fe80::/64                On-link
 63   5256 fe80::29f0:3175:37b2:374c/128
                                    On-link
 55   5256 fe80::68d3:c014:6cd1:bc2f/128
                                    On-link
 48   5256 fe80::95af:80d:2d08:da5c/128
                                    On-link
  1    331 ff00::/8                 On-link
 48   5256 ff00::/8                 On-link
 55   5256 ff00::/8                 On-link
 63   5256 ff00::/8                 On-link
===========================================================================
Постоянные маршруты:
  Отсутствует
```


### **5. IP routing table on host2**

**`ip route show`**

```console
default via 192.168.88.1 dev eth0 proto dhcp src 192.168.88.111 metric 100
10.10.10.0/26 via 172.31.255.111 dev eth1
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown
172.31.255.0/25 dev eth1 proto kernel scope link src 172.31.255.111
192.168.88.0/24 dev eth0 proto kernel scope link src 192.168.88.111
192.168.88.1 dev eth0 proto dhcp scope link src 192.168.88.111 metric 100
```


### **6. IP routing table on host3**

**`ip route show`**

```console
10.10.10.0/26 dev eth2 proto kernel scope link src 10.10.10.2
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown
172.31.255.0/25 dev eth1 proto kernel scope link src 172.31.255.2
192.168.88.0/24 via 172.31.255.111 dev eth1
```

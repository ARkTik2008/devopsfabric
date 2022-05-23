# DEVOPS-054 routing exercise with route

## L3 logical network diagram

![L3 logical network diagram](/DEVOPS-054/network_diagram.png)


### **Hosts:**
1. Host1 (Ubuntu 20.04 virtualized).
2. Host2 (Ubuntu 20.04 virtualized).
3. Host3 (Ubuntu 20.04 virtualized).


### **Subnets:**
1. 192.168.11.0/24.
2. 172.31.255.0/25.
3. 10.10.10.0/26.


---


## **Set static routing**
### **1. On host1**

```console
apt install -y net-tools
ip link set eth0 down
ip link set eth1 up
ip a add 192.168.11.1/24 dev eth1
route add default gw 192.168.11.1
route add -net 172.31.255.0/25 gw 192.168.11.2 dev eth1
route add -net 10.10.10.0/26 gw 192.168.11.2 dev eth1
# 'route add' works w/o gw too
#route add -net 172.31.255.0/25 dev eth1
#route add -net 10.10.10.0/26 dev eth1
```

### **2. On host2**

```console
apt install -y net-tools
ip link set eth0 down
ip link set eth1 up
ip link set eth2 up
ip a add 192.168.11.2/24 dev eth1
ip a add 172.31.255.2/25 dev eth2
route add -net 10.10.10.0/26 gw 172.31.255.3 dev eth2
# 'route add' works w/o gw too
#route add -net 10.10.10.0/26 dev eth2
iptables -P FORWARD ACCEPT
```

### **3. On host3**

```console
apt install -y net-tools
ip link set eth0 down
ip link set eth1 up
ip link set eth2 up
ip a add 172.31.255.3/25 dev eth1
ip a add 10.10.10.3/26 dev eth2
route add -net 192.168.11.0/24 gw 172.31.255.2 dev eth1
# 'route add' works w/o gw too
#route add -net 192.168.11.0/24 dev eth1
```


## **Validating the task**
### **1. Network connectivity from host1 to eth2 host3**

**`ping 10.10.10.3`**

![ping 10.10.10.3](/DEVOPS-054/ping_10.10.10.3.png)

### **2. Network connectivity from host3 to eth1 host2**
**`ping 192.168.11.2`**

![ping 192.168.11.2](/DEVOPS-054/ping_192.168.11.2.png)

### **3. Curl from host3 to nginx host2**
**`curl -Ik --resolve main.fabric:80:192.168.11.2 http://main.fabric`**

![Curl from host3 to nginx host2](/DEVOPS-054/curl_host3-nginx_host2.png)

### **4. IP routing table on host1**

**`route`**

![IP routing table on host1](/DEVOPS-054/host1_routes.png)


### **5. IP routing table on host2**

**`route`**

![IP routing table on host2](/DEVOPS-054/host2_routes.png)


### **6. IP routing table on host3**

**`route`**

![IP routing table on host3](/DEVOPS-054/host3_routes.png)

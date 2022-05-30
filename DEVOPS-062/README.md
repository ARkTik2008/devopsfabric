# DEVOPS-062 iptables NAT configuration

## L3 logical network diagram

![L3 logical network diagram](/DEVOPS-062/network_diagram.png)


### **Hosts:**
1. Host1 (Ubuntu 20.04 virtualized).
2. Host2 (Ubuntu 20.04 virtualized).
3. Host3 (Ubuntu 20.04 virtualized).


### **Subnets:**
1. 192.168.11.0/24.
2. 172.31.255.0/25.
3. 10.10.10.0/26.


---


## **Set static routing and NAT**
### **1. On host1**

```console
ip link set eth0 down
ip link set eth1 up
ip a add 192.168.11.1/24 dev eth1
route add -net 172.31.255.0/25 gw 192.168.11.2 dev eth1
route add -net 10.10.10.0/26 gw 192.168.11.2 dev eth1
```

### **2. On host2**

```console
ip link set eth0 down
ip link set eth1 up
ip link set eth2 up
ip a add 192.168.11.2/24 dev eth1
ip a add 172.31.255.2/25 dev eth2
route add -net 10.10.10.0/26 gw 172.31.255.3 dev eth2
iptables -P FORWARD ACCEPT
# NAT
iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE
# tcpdump
tcpdump -nni eth1 icmp -w /tmp/tcpdump_host2.cap
```

### **3. On host3**

```console
ip link set eth0 down
ip link set eth1 up
ip link set eth2 up
ip a add 172.31.255.3/25 dev eth1
ip a add 10.10.10.3/26 dev eth2
route add -net 192.168.11.0/24 gw 172.31.255.2 dev eth1
# tcpdump
tcpdump -nni eth1 icmp -w /tmp/tcpdump_host3.cap
```


## **Validating the task**
### **Wireshark screen with cap-file from host2**

![wireshark_tcpdump_host2](/DEVOPS-062/wireshark_tcpdump_host2.png)


### **Wireshark screen with cap-file from host3**

![wireshark_tcpdump_host3](/DEVOPS-062/wireshark_tcpdump_host3.png)

# DEVOPS-083 ssh proxy exercise

## 1. Open SSH tunnel to remote postgresql server
```bash
ssh -L 65534:localhost:5432 dmitriy@192.168.88.111 -p 222
```
where are:  
`'-L 65534'` - local port number of the tunnel (any unused in range 49152-65535),  
`'localhost'` - remote bind address we are connecting (localhost by default),  
`'5432'` - remote end of the tunnel (remote server port),  
`'dmitriy@192.168.88.111 -p 222'` - ssh login, remote host and port to connect.  


## 2. Connect to remote postgres server via SSH tunnel
```bash
psql -h localhost -p 65534 postgres
```
now `'psql'` can connect to remote postgres server as if it were a local server like `'localhost:65534'`.


## 3. Iptables supplement
SSH tunnel functioning needs allowing loopback connections!
```bash
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
```


---


## Screenshot

![screenshot](/DEVOPS-083/screenshot.png)

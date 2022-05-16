# DEVOPS-012 hugo game play

## Site building steps 

1. #### installing newest golang version
```
mkdir -p /tmp/go/
cd /tmp/go/
wget https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
```
    go version
    go version go1.18.2 linux/amd64

---

2. #### installing newest hugo version
```
mkdir -p /tmp/hugo/
cd /tmp/hugo/
wget https://github.com/gohugoio/hugo/releases/download/v0.98.0/hugo_extended_0.98.0_Linux-64bit.tar.gz
tar -xvzf hugo_extended_0.98.0_Linux-64bit.tar.gz
cp -f hugo /usr/bin/
```
    hugo version
	hugo v0.98.0-165d299cde259c8b801abadc6d3405a229e449f6+extended linux/amd64 BuildDate=2022-04-28T10:23:30Z VendorInfo=gohugoio

---

3. #### creating new hugo site
```
cd /home/dmitriy/WindowsShare/pashkov_dmitriy/DEVOPS-012
hugo new site joke.fabric -f yml
```

---

4. #### adding theme PaperMod
```
cd /home/dmitriy/WindowsShare/pashkov_dmitriy/DEVOPS-012/joke.fabric
git clone https://github.com/adityatelange/hugo-PaperMod themes/PaperMod --depth=1
cd themes/PaperMod
git config --global --add safe.directory /home/dmitriy/WindowsShare/pashkov_dmitriy/DEVOPS-012/joke.fabric/themes/PaperMod
git pull
```

---

5. #### fixing nginx config
```
vi /etc/nginx/main.fabric.conf
location = /helloworld {
---try_files $uri /hello.html;
```
```
nginx -t && nginx -s reload
```

---

6. #### making site directory
```
mkdir /var/www/main.fabric/html/helloworld
```

---

7. #### creating new post
```
cd /home/dmitriy/WindowsShare/pashkov_dmitriy/DEVOPS-012/joke.fabric
hugo new posts/chuck-norris.md
```
```
vi chuck-norris.md
---draft: true
+++draft: false
```

---

8. #### starting hugo server
```
hugo server -D
```

9. #### building static page in site directory
```
hugo --destination /var/www/main.fabric/html/helloworld/
```

---

![/helloworld](/DEVOPS-012/helloworld.png)

![/helloworld/posts/](/DEVOPS-012/helloworld-post.png)
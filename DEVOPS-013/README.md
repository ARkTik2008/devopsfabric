# DEVOPS-013 apache configuration

## Apache2 configuring steps

1. #### installing apache2
```console
apt update
apt install apache2
systemctl enable apache2
systemctl start apache2
```

	
2. #### denying all requests to default site
#### allowing .htaccess 
```console
vi /etc/apache2/apache2.conf
<Directory /var/www/>
        Options Indexes FollowSymLinks
---     AllowOverride None
+++     AllowOverride All
        Require all granted
</Directory>
```

#### copying .htaccess for default site
```console
cp --force .htaccess_default /var/www/html/.htaccess
cat /var/www/html/.htaccess
```
    Deny from all

3. #### adding new site config
```console
mkdir /var/www/main.fabric/
cp --force index.html /var/www/main.fabric/
cp --force main.fabric.conf /etc/apache2/sites-available/
a2ensite main.fabric.conf
systemctl reload apache2
cat /etc/apache2/sites-enabled/main.fabric.conf
```
    <VirtualHost *:80>
    ServerName main.fabric
    DocumentRoot /var/www/main.fabric
    DirectoryIndex index.html
    ErrorLog ${APACHE_LOG_DIR}/main.fabric.error.log
    CustomLog ${APACHE_LOG_DIR}/main.fabric.access.log combined
    <Directory /var/www/main.fabric>
        # Allow .htaccess 
        AllowOverride All
        Allow from All
    </Directory>    
    </VirtualHost>



4. #### creating location /helloworld
```console
mkdir /var/www/main.fabric/helloworld
cp --force hello.html /var/www/main.fabric/helloworld/
cp --force .htaccess_helloworld /var/www/main.fabric/helloworld/.htaccess
cat /var/www/main.fabric/helloworld/.htaccess
```
    DirectoryIndex hello.html


5. #### redirecting location /redirect
```console
cp --force .htaccess_main.fabric /var/www/main.fabric/.htaccess
cat /var/www/main.fabric/.htaccess
```
    RedirectPermanent /redirect https://fabric.baikalteam.com

---

6. ## Validating the task

**`curl -Ik http://127.0.0.1:80`**
```
HTTP/1.1 403 Forbidden
Date: Mon, 16 May 2022 14:50:24 GMT
Server: Apache/2.4.41 (Ubuntu)
Content-Type: text/html; charset=iso-8859-1
```

**`curl -Ik http://127.0.0.1:80/index.html`**
```
HTTP/1.1 403 Forbidden
Date: Mon, 16 May 2022 14:51:09 GMT
Server: Apache/2.4.41 (Ubuntu)
Content-Type: text/html; charset=iso-8859-1
```

**`curl -Ik http://127.0.0.1/some-fake-uri.php`**
```
HTTP/1.1 403 Forbidden
Date: Mon, 16 May 2022 14:52:00 GMT
Server: Apache/2.4.41 (Ubuntu)
Content-Type: text/html; charset=iso-8859-1
```

**`curl -Ik http://main.fabric:80`**
```
curl: (6) Could not resolve host: main.fabric
```


**`curl -Ik --resolve main.fabric:80:192.168.88.108 http://main.fabric`**
```
HTTP/1.1 200 OK
Date: Mon, 16 May 2022 16:40:25 GMT
Server: Apache/2.4.41 (Ubuntu)
Last-Modified: Mon, 16 May 2022 15:02:31 GMT
ETag: "2aa6-5df225040aa99"
Accept-Ranges: bytes
Content-Length: 10918
Vary: Accept-Encoding
Content-Type: text/html
```

**`curl -Ik --resolve main.fabric:80:192.168.88.108 http://main.fabric/helloworld`**
```
HTTP/1.1 301 Moved Permanently
Date: Mon, 16 May 2022 16:41:49 GMT
Server: Apache/2.4.41 (Ubuntu)
Location: http://main.fabric/helloworld/
Content-Type: text/html; charset=iso-8859-1
```

**`curl -Ik --resolve main.fabric:80:192.168.88.108 http://main.fabric/helloworld/`**
```
HTTP/1.1 200 OK
Date: Mon, 16 May 2022 16:42:24 GMT
Server: Apache/2.4.41 (Ubuntu)
Last-Modified: Mon, 16 May 2022 16:03:25 GMT
ETag: "269-5df232a09a839"
Accept-Ranges: bytes
Content-Length: 617
Vary: Accept-Encoding
Content-Type: text/html
```

**`curl -Ik --resolve main.fabric:80:192.168.88.108 http://main.fabric/redirect`**
```
HTTP/1.1 301 Moved Permanently
Date: Mon, 16 May 2022 16:43:09 GMT
Server: Apache/2.4.41 (Ubuntu)
Location: https://fabric.baikalteam.com
Content-Type: text/html; charset=iso-8859-1
```

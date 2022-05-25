# DEVOPS-061 nginx hardening

## List of files:

### 1. nginx_install.sh
shell script to install NGINX web server.
### 2. nginx_config.sh
shell script to configure NGINX web server.
### 3. default.conf
NGINX configuration file with default server.
### 4. dmitriy.fabric.baikalteam.com.conf
NGINX subdomain configuration on virtual host dmitriy.fabric.baikalteam.com.
### 5. certbot_run.sh
script to install certbot and configure NGINX with A+ SSL Test rating.

---

## I. NGINX configuration
### Virtual Host configuration for domain dmitriy.fabric.baikalteam.com
```console
server {
       server_name dmitriy.fabric.baikalteam.com;
       root /var/www/dmitriy.fabric.baikalteam.com/html;
       index index.html;
       location / {
              try_files $uri $uri/ =404;
       }
           location = /helloworld {
              try_files $uri /hello.html;
       }
           location = /redirect {
               return 302 https://fabric.baikalteam.com/;
       }

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/dmitriy.fabric.baikalteam.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/dmitriy.fabric.baikalteam.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = dmitriy.fabric.baikalteam.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


       listen 80;
       listen [::]:80;
       server_name dmitriy.fabric.baikalteam.com;
    return 404; # managed by Certbot
```


## II. Certbot command

### Interactive mode

```console
certbot --nginx
```

### Automatic mode

```console
certbot --nginx --agree-tos --redirect --hsts --staple-ocsp --email pashkov.dmitriy@gmail.com -d dmitriy.fabric.baikalteam.com
```

## III. A+ SSL Test Rating

### Enabling HSTS with more than 1 week duration (satisified A+ SSL Test rating)
```console
cat >> /etc/letsencrypt/options-ssl-nginx.conf <<EOF
add_header Strict-Transport-Security "max-age=63072000;";
EOF
```

## IV. Certbot's current rate limits
1. 50 certificates per Registered Domain per week (error message: too many certificates already issued)
2. 300 new orders per account per 3 hours (error message: too many new orders recently)
3. 100 names per certificate (no error message)
4. 5 duplicate certificate per week (error message: too many certificates already issued for exact set of domains)
5. 5 failed validations per account per hostname per hour (error message: too many failed authorizations recently)
6. 10 accounts per IP address per 3 hours (error message: too many registrations for this IP)
7. 500 accounts per IP range within an IPv6 /48 per 3 hours (error message: too many registrations for this IP)
8. 300 pending authorizations per account (error message: too many currently pending authorizations)


## V. SSLLab screenshot

![SSLLab A+](/DEVOPS-061/A+.png)  

<https://www.ssllabs.com/ssltest/analyze.html?d=dmitriy.fabric.baikalteam.com>

## VI. Uptimerobot email alert

![Uptimerobot email alert](/DEVOPS-061/mail_alert.png)
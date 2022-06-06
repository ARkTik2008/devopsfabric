# DEVOPS-073 mysql exercise
## List of files:

### 1. mysql_install.sh
Bash script to install MySQL server.
### 2. application_users.sql
List of sql-commands which create db and users.
### 3. apply_sql.sh
Bash script that executes sql-commands from previous file, and allows incoming requests on port 3306 from trusted network ranges.
### 4. README.md
this file.

---

## 1. Bash script to install MySQL server
Unattended installation of MySQL server.  
Tail of script's output:

```console
Setting up mysql-community-client (8.0.29-1ubuntu20.04) ...
Setting up mysql-client (8.0.29-1ubuntu20.04) ...
Setting up mysql-community-server (8.0.29-1ubuntu20.04) ...
update-alternatives: using /etc/mysql/mysql.cnf to provide /etc/mysql/my.cnf (my.cnf) in auto mode
Created symlink /etc/systemd/system/multi-user.target.wants/mysql.service → /lib/systemd/system/mysql.service.
Setting up mysql-server (8.0.29-1ubuntu20.04) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.7) ...
mysql_secure_installation: [Warning] Using a password on the command line interface can be insecure.

Securing the MySQL server deployment.

VALIDATE PASSWORD COMPONENT can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. Would you like to setup VALIDATE PASSWORD component?

Press y|Y for Yes, any other key for No:  y

There are three levels of password validation policy:

LOW    Length >= 8
MEDIUM Length >= 8, numeric, mixed case, and special characters
STRONG Length >= 8, numeric, mixed case, special characters and dictionary                  file

Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG:  2
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) :  y
Success.

Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) :  y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.

Remove test database and access to it? (Press y|Y for Yes, any other key for No) :  y
 - Dropping test database...
Success.

 - Removing privileges on test database...
Success.

Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) :  y
Success.

All done!
mysqladmin: [Warning] Using a password on the command line interface can be insecure.
mysqld is alive
#########################################
MySQL password is: TVmXbiNfHEXycr2iYY8=
#########################################
Password is stored in /tmp/mysql.log
```

## 2. sql-commands to create db and users

```console
CREATE DATABASE application;

CREATE USER 'app'@'10.10.0.176/28' IDENTIFIED WITH mysql_native_password BY 'strong_password_here';
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT ON application.* TO 'app'@'10.10.0.176/28';

CREATE USER 'app_debug'@'172.16.0.128/26' IDENTIFIED WITH mysql_native_password BY 'strong_password_here';
CREATE USER 'app_debug'@'172.16.0.192/29' IDENTIFIED WITH mysql_native_password BY 'strong_password_here';
GRANT SELECT ON application.* TO 'app_debug'@'172.16.0.128/26', 'app_debug'@'172.16.0.192/29';

CREATE USER 'app_backup'@'localhost' IDENTIFIED WITH auth_socket;
GRANT SELECT ON application.* TO 'app_backup'@'localhost';

FLUSH PRIVILEGES;
```

---

## 3. Bash script to executes sql-commands and open port 3306

```bash
mysql -u root < application_users.sql

iptables -A INPUT -p tcp --destination-port 3306 -m iprange --src-range 10.10.0.177-10.10.0.190 -j ACCEPT

iptables -A INPUT -p tcp --destination-port 3306 -m iprange --src-range 172.16.0.129-172.16.0.198 -j ACCEPT

```

### Script outputs nothing into console.

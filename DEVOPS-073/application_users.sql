CREATE DATABASE application;

CREATE USER 'app'@'10.10.0.176/28' IDENTIFIED WITH mysql_native_password BY 'CgYH6ppm9qJGeeAq6VEd!';
GRANT SELECT, INSERT, UPDATE, DELETE ON application.* TO 'app'@'10.10.0.176/28';

CREATE USER 'app_debug'@'172.16.0.128/27' IDENTIFIED WITH mysql_native_password BY 'eLg5G2jr2r6hV4Luv87B*';
GRANT SELECT ON application.* TO 'app_debug'@'172.16.0.128/27';

CREATE USER 'app_backup'@'localhost' IDENTIFIED WITH auth_socket;
GRANT SELECT, LOCK TABLES ON application.* TO 'app_backup'@'localhost';

FLUSH PRIVILEGES;

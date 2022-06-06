CREATE DATABASE application;

CREATE USER 'app'@'10.10.0.176/28' IDENTIFIED WITH mysql_native_password BY 'CgYH6ppm9qJGeeAq6VEd!';
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT ON application.* TO 'app'@'10.10.0.176/28';

CREATE USER 'app_debug'@'172.16.0.128/26' IDENTIFIED WITH mysql_native_password BY 'eLg5G2jr2r6hV4Luv87B*';
CREATE USER 'app_debug'@'172.16.0.192/29' IDENTIFIED WITH mysql_native_password BY 'eLg5G2jr2r6hV4Luv87B*';
GRANT SELECT ON application.* TO 'app_debug'@'172.16.0.128/26', 'app_debug'@'172.16.0.192/29';

CREATE USER 'app_backup'@'localhost' IDENTIFIED WITH auth_socket;
GRANT SELECT ON application.* TO 'app_backup'@'localhost';

FLUSH PRIVILEGES;

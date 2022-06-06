# DEVOPS-074 mysql schema

## List of files:
### 1. schema-erd.sql
List of SQL-commands which realize simple mysql schema from the task.
### 2. backup.sql
DB dump needed for SQLFairy.
### 3. schema.png
PNG image of the DB schema.
### 4. README.md
this file.

---

## Creating database

```console
CREATE DATABASE IF NOT EXISTS application;
USE application;

CREATE TABLE IF NOT EXISTS ap (
    contr_id INT,
    apid INT,
    boot_script VARCHAR(255),
    description VARCHAR(100),
    building VARCHAR(100),
    location VARCHAR(100),
	dataplan_encryption VARCHAR(100),
    mac_address VARCHAR(20),
    model VARCHAR(30),
    power_suply VARCHAR(30),
    config_id INT,
    PRIMARY KEY (contr_id, apid)
);

CREATE TABLE IF NOT EXISTS controller (
    contr_id INT PRIMARY KEY,
    name VARCHAR(40),
    ipaddr VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS essap (
    contr_id INT,
    apid INT,
    ifaceid INT,
    essid VARCHAR(200),
    calls_per_bss INT,
    config_id INT,
    PRIMARY KEY (contr_id, apid, ifaceid, essid)
);

CREATE TABLE IF NOT EXISTS interface (
    contr_id INT,
    apid INT,
    ifaceid INT,
    config_id INT,
    channel VARCHAR(4),
    rf_mode VARCHAR(20),
    localpower VARCHAR(5),
    channel_width VARCHAR(20),
    protection_cts_mode VARCHAR(20),
    protection_mode VARCHAR(20),
    virtual_cell_mode VARCHAR(10),
    PRIMARY KEY (contr_id, apid, ifaceid)
);

CREATE TABLE IF NOT EXISTS text_configs (
    config_id INT PRIMARY KEY,
    contr_id INT,
    orig_text LONGTEXT,
    download_ts INT,
    parsed_text LONGTEXT,
    orig_filename VARCHAR(100)
);

ALTER TABLE ap
    ADD FOREIGN KEY (contr_id) REFERENCES controller (contr_id),
    ADD FOREIGN KEY (config_id) REFERENCES text_configs (config_id);

ALTER TABLE essap
    ADD FOREIGN KEY (contr_id, apid, ifaceid) REFERENCES interface (contr_id, apid, ifaceid),
    ADD FOREIGN KEY (config_id) REFERENCES text_configs (config_id);

ALTER TABLE interface
    ADD FOREIGN KEY (contr_id, apid) REFERENCES ap (contr_id, apid),
    ADD FOREIGN KEY (config_id) REFERENCES text_configs (config_id);

ALTER TABLE  text_configs
    ADD INDEX (contr_id),
    ADD FOREIGN KEY (contr_id) REFERENCES controller (contr_id);
```




## Visualisation of database schema using SQLFairy

```console
apt-get install -y sqlfairy
mysqldump -u root -d application > backup.sql
sqlt-diagram --db=MySQL -o schema.png -i png -t "application schema" --color --gutter 100 -c 2 backup.sql
```

## Diagram of MySQL Schema
![diagram](/DEVOPS-074/schema.png)

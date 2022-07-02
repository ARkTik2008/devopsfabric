# DEVOPS-113 mongodb backup

В коллекцию [mongodb](/ansible/collections/ansible_collections/sudmed/mongodb/) добавлена новая роль `mongo-backup`. Роль позволяет выполнить три варианта резервного копирования:  
1. бэкап всех БД по крону раз в сутки (вариант по умолчанию).

2. бэкап определенных БД по крону раз в сутки, выполняется если задана переменная   `mongo_backup_db` и в нее переданы названия бэкапируемых БД. Например:
```bash
role\defaults\main.yml => mongo_backup_db: "stage_db1 stage_db3 stage_db5"
```
```bash
ansible-playbook --extra-vars 'mongo_backup_db="stage_db1 stage_db3 stage_db5"'
```

3. бэкап одной определенной БД однократно немедленно, выполняется если задана переменная с названием `mongo_backup_now`, содержащая имя бэкапируемой БД:
```bash
ansible-playbook playbook.yml --extra-vars "mongo_backup_now=stage_db5"
```

## Vars:
* mongo_host: "localhost"
* mongo_port: "28000"
* mongo_backup_path: "/usr/local/mongodb_backups"
* mongo_backup_db: "ALL"
* \# mongo_backup_db: "stage_db1 stage_db2 stage_db4"
* mongo_backup_hour: "0"
* mongo_backup_minute: "15"
* backup_retain_days: "30"


## Восстановление данных из бэкапа:
`mongorestore --gzip --drop --archive=/path/to/db_file.gz`

---

## Validation 

### 1. Default backup (set to cron backuping all databases)

```bash
ansible-playbook playbook-113.yml -u dmitriy --private-key /home/root1/.ssh/id_ed25519 -K -l host1
```

```yaml
BECOME password:

PLAY [Deploy MongoDB] ********************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************************
ok: [host1]

TASK [sudmed.mongodb.mongo-backup : Check if backup user exists] *************************************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Create MongoDB user backup] **************************************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Copy backup script] **********************************************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Set up script on cron] *******************************************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Immediately backup standalone db {{ mongo_backup_now }}] *********************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Show results of immediately backup] ******************************************************************************************************************************************************
skipping: [host1]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=4    changed=3    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
```

#### Check cronjob
`sudo crontab -l`  

```bash
#Ansible: Daily mongo backup ALL
15 0 * * * /usr/local/bin/mongodb_backup.sh ALL > /dev/null 2>&1
```

#### Running a cron job manually and immediately
`sudo /usr/local/bin/mongodb_backup.sh ALL`  
```bash
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
The backup script for MongoDB
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Starting backup for all databases
2022-07-02T16:09:24.754+0000    writing admin.system.users to /usr/local/mongodb_backups/2022-07-02/admin/system.users.bson.gz
2022-07-02T16:09:24.755+0000    done dumping admin.system.users (5 documents)
2022-07-02T16:09:24.755+0000    writing admin.system.version to /usr/local/mongodb_backups/2022-07-02/admin/system.version.bson.gz
2022-07-02T16:09:24.755+0000    done dumping admin.system.version (3 documents)
2022-07-02T16:09:24.756+0000    writing application.mycollection to /usr/local/mongodb_backups/2022-07-02/application/mycollection.bson.gz
2022-07-02T16:09:24.756+0000    writing stage_db1.collection1 to /usr/local/mongodb_backups/2022-07-02/stage_db1/collection1.bson.gz
2022-07-02T16:09:24.756+0000    writing stage_db1.collection2 to /usr/local/mongodb_backups/2022-07-02/stage_db1/collection2.bson.gz
2022-07-02T16:09:24.757+0000    writing stage_db1.collection3 to /usr/local/mongodb_backups/2022-07-02/stage_db1/collection3.bson.gz
2022-07-02T16:09:24.764+0000    done dumping stage_db1.collection2 (1000 documents)
2022-07-02T16:09:24.764+0000    writing stage_db1.collection4 to /usr/local/mongodb_backups/2022-07-02/stage_db1/collection4.bson.gz
2022-07-02T16:09:24.766+0000    done dumping stage_db1.collection3 (1000 documents)
2022-07-02T16:09:24.766+0000    writing stage_db2.collection2 to /usr/local/mongodb_backups/2022-07-02/stage_db2/collection2.bson.gz
2022-07-02T16:09:24.767+0000    done dumping stage_db1.collection1 (1000 documents)
2022-07-02T16:09:24.767+0000    writing stage_db2.collection4 to /usr/local/mongodb_backups/2022-07-02/stage_db2/collection4.bson.gz
2022-07-02T16:09:24.770+0000    done dumping stage_db2.collection2 (1000 documents)
2022-07-02T16:09:24.774+0000    done dumping stage_db1.collection4 (1000 documents)
2022-07-02T16:09:24.774+0000    writing stage_db2.collection1 to /usr/local/mongodb_backups/2022-07-02/stage_db2/collection1.bson.gz
2022-07-02T16:09:24.774+0000    writing stage_db2.collection3 to /usr/local/mongodb_backups/2022-07-02/stage_db2/collection3.bson.gz
2022-07-02T16:09:24.775+0000    done dumping application.mycollection (1000 documents)
2022-07-02T16:09:24.781+0000    done dumping stage_db2.collection1 (1000 documents)
2022-07-02T16:09:24.781+0000    writing stage_db3.collection2 to /usr/local/mongodb_backups/2022-07-02/stage_db3/collection2.bson.gz
2022-07-02T16:09:24.781+0000    writing stage_db3.collection4 to /usr/local/mongodb_backups/2022-07-02/stage_db3/collection4.bson.gz
2022-07-02T16:09:24.782+0000    done dumping stage_db2.collection4 (1000 documents)
2022-07-02T16:09:24.782+0000    writing stage_db3.collection1 to /usr/local/mongodb_backups/2022-07-02/stage_db3/collection1.bson.gz
2022-07-02T16:09:24.784+0000    done dumping stage_db2.collection3 (1000 documents)
2022-07-02T16:09:24.784+0000    writing stage_db3.collection3 to /usr/local/mongodb_backups/2022-07-02/stage_db3/collection3.bson.gz
2022-07-02T16:09:24.787+0000    done dumping stage_db3.collection1 (1000 documents)
2022-07-02T16:09:24.787+0000    done dumping stage_db3.collection4 (1000 documents)
2022-07-02T16:09:24.787+0000    writing stage_db4.collection3 to /usr/local/mongodb_backups/2022-07-02/stage_db4/collection3.bson.gz
2022-07-02T16:09:24.788+0000    writing stage_db4.collection4 to /usr/local/mongodb_backups/2022-07-02/stage_db4/collection4.bson.gz
2022-07-02T16:09:24.790+0000    done dumping stage_db3.collection2 (1000 documents)
2022-07-02T16:09:24.791+0000    done dumping stage_db3.collection3 (1000 documents)
2022-07-02T16:09:24.791+0000    writing stage_db4.collection1 to /usr/local/mongodb_backups/2022-07-02/stage_db4/collection1.bson.gz
2022-07-02T16:09:24.794+0000    done dumping stage_db4.collection3 (1000 documents)
2022-07-02T16:09:24.794+0000    writing stage_db5.collection4 to /usr/local/mongodb_backups/2022-07-02/stage_db5/collection4.bson.gz
2022-07-02T16:09:24.794+0000    writing stage_db4.collection2 to /usr/local/mongodb_backups/2022-07-02/stage_db4/collection2.bson.gz
2022-07-02T16:09:24.795+0000    done dumping stage_db4.collection1 (1000 documents)
2022-07-02T16:09:24.795+0000    writing stage_db5.collection2 to /usr/local/mongodb_backups/2022-07-02/stage_db5/collection2.bson.gz
2022-07-02T16:09:24.797+0000    done dumping stage_db5.collection4 (1000 documents)
2022-07-02T16:09:24.798+0000    writing stage_db5.collection1 to /usr/local/mongodb_backups/2022-07-02/stage_db5/collection1.bson.gz
2022-07-02T16:09:24.799+0000    done dumping stage_db5.collection2 (1000 documents)
2022-07-02T16:09:24.800+0000    writing stage_db5.collection3 to /usr/local/mongodb_backups/2022-07-02/stage_db5/collection3.bson.gz
2022-07-02T16:09:24.801+0000    done dumping stage_db4.collection4 (1000 documents)
2022-07-02T16:09:24.805+0000    done dumping stage_db4.collection2 (1000 documents)
2022-07-02T16:09:24.806+0000    done dumping stage_db5.collection3 (1000 documents)
2022-07-02T16:09:24.807+0000    done dumping stage_db5.collection1 (1000 documents)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
The script was executed successfully.
List of backups:
----------------------------------------------------------------
/usr/local/mongodb_backups/2022-07-02/
├── admin
│   ├── system.users.bson.gz
│   ├── system.users.metadata.json.gz
│   ├── system.version.bson.gz
│   └── system.version.metadata.json.gz
├── application
│   ├── mycollection.bson.gz
│   └── mycollection.metadata.json.gz
├── stage_db1
│   ├── collection1.bson.gz
│   ├── collection1.metadata.json.gz
│   ├── collection2.bson.gz
│   ├── collection2.metadata.json.gz
│   ├── collection3.bson.gz
│   ├── collection3.metadata.json.gz
│   ├── collection4.bson.gz
│   └── collection4.metadata.json.gz
├── stage_db2
│   ├── collection1.bson.gz
│   ├── collection1.metadata.json.gz
│   ├── collection2.bson.gz
│   ├── collection2.metadata.json.gz
│   ├── collection3.bson.gz
│   ├── collection3.metadata.json.gz
│   ├── collection4.bson.gz
│   └── collection4.metadata.json.gz
├── stage_db3
│   ├── collection1.bson.gz
│   ├── collection1.metadata.json.gz
│   ├── collection2.bson.gz
│   ├── collection2.metadata.json.gz
│   ├── collection3.bson.gz
│   ├── collection3.metadata.json.gz
│   ├── collection4.bson.gz
│   └── collection4.metadata.json.gz
├── stage_db4
│   ├── collection1.bson.gz
│   ├── collection1.metadata.json.gz
│   ├── collection2.bson.gz
│   ├── collection2.metadata.json.gz
│   ├── collection3.bson.gz
│   ├── collection3.metadata.json.gz
│   ├── collection4.bson.gz
│   └── collection4.metadata.json.gz
└── stage_db5
    ├── collection1.bson.gz
    ├── collection1.metadata.json.gz
    ├── collection2.bson.gz
    ├── collection2.metadata.json.gz
    ├── collection3.bson.gz
    ├── collection3.metadata.json.gz
    ├── collection4.bson.gz
    └── collection4.metadata.json.gz

7 directories, 46 files
```


---


### 2. Set to cron backuping of standalone dbs

```bash
ansible-playbook playbook-113.yml -u dmitriy --private-key /home/root1/.ssh/id_ed25519 -K -l host1 --extra-vars 'mongo_backup_db="stage_db1 stage_db3 stage_db5"'
```

```yaml
BECOME password:

PLAY [Deploy MongoDB] ********************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************************
ok: [host1]

TASK [sudmed.mongodb.mongo-backup : Check if backup user exists] *************************************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Create MongoDB user backup] **************************************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Copy backup script] **********************************************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Set up script on cron] *******************************************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Immediately backup standalone db {{ mongo_backup_now }}] *********************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Show results of immediately backup] ******************************************************************************************************************************************************
skipping: [host1]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=4    changed=3    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
```


### Check cronjob
`sudo crontab -e`
```bash
#Ansible: Daily mongo backup stage_db1 stage_db3 stage_db5
15 0 * * * /usr/local/bin/mongodb_backup.sh stage_db1 stage_db3 stage_db5 > /dev/null 2>&1
```

### Running a cron job manually and immediately
`sudo /usr/local/bin/mongodb_backup.sh stage_db1 stage_db3 stage_db5`
```bash
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
The backup script for MongoDB
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Starting backup for databases: stage_db1 stage_db3 stage_db5
2022-07-02T16:18:30.664+0000    writing stage_db1.collection1 to archive 'stage_db1.gz'
2022-07-02T16:18:30.665+0000    writing stage_db1.collection3 to archive 'stage_db1.gz'
2022-07-02T16:18:30.676+0000    writing stage_db1.collection2 to archive 'stage_db1.gz'
2022-07-02T16:18:30.676+0000    writing stage_db1.collection4 to archive 'stage_db1.gz'
2022-07-02T16:18:30.681+0000    done dumping stage_db1.collection3 (1000 documents)
2022-07-02T16:18:30.688+0000    done dumping stage_db1.collection4 (1000 documents)
2022-07-02T16:18:30.688+0000    done dumping stage_db1.collection2 (1000 documents)
2022-07-02T16:18:30.689+0000    done dumping stage_db1.collection1 (1000 documents)
DB stage_db1 was successfully archived in: /usr/local/mongodb_backups/2022-07-02/
2022-07-02T16:18:30.706+0000    writing stage_db3.collection4 to archive 'stage_db3.gz'
2022-07-02T16:18:30.706+0000    writing stage_db3.collection1 to archive 'stage_db3.gz'
2022-07-02T16:18:30.708+0000    writing stage_db3.collection3 to archive 'stage_db3.gz'
2022-07-02T16:18:30.710+0000    writing stage_db3.collection2 to archive 'stage_db3.gz'
2022-07-02T16:18:30.715+0000    done dumping stage_db3.collection4 (1000 documents)
2022-07-02T16:18:30.716+0000    done dumping stage_db3.collection1 (1000 documents)
2022-07-02T16:18:30.721+0000    done dumping stage_db3.collection3 (1000 documents)
2022-07-02T16:18:30.721+0000    done dumping stage_db3.collection2 (1000 documents)
DB stage_db3 was successfully archived in: /usr/local/mongodb_backups/2022-07-02/
2022-07-02T16:18:30.737+0000    writing stage_db5.collection2 to archive 'stage_db5.gz'
2022-07-02T16:18:30.737+0000    writing stage_db5.collection1 to archive 'stage_db5.gz'
2022-07-02T16:18:30.740+0000    writing stage_db5.collection3 to archive 'stage_db5.gz'
2022-07-02T16:18:30.740+0000    writing stage_db5.collection4 to archive 'stage_db5.gz'
2022-07-02T16:18:30.744+0000    done dumping stage_db5.collection2 (1000 documents)
2022-07-02T16:18:30.754+0000    done dumping stage_db5.collection1 (1000 documents)
2022-07-02T16:18:30.754+0000    done dumping stage_db5.collection3 (1000 documents)
2022-07-02T16:18:30.754+0000    done dumping stage_db5.collection4 (1000 documents)
DB stage_db5 was successfully archived in: /usr/local/mongodb_backups/2022-07-02/
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
The script was executed successfully.
List of backups:
----------------------------------------------------------------
/usr/local/mongodb_backups/2022-07-02/
├── stage_db1.gz
├── stage_db3.gz
└── stage_db5.gz

0 directories, 3 files
```


---


### 3. Immediately backup

```bash
ansible-playbook playbook-113.yml -u dmitriy --private-key /home/root1/.ssh/id_ed25519 -K -l host1 --extra-vars "mongo_backup_now=stage_db2"
```

```yaml
BECOME password:

PLAY [Deploy MongoDB] ********************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************************
ok: [host1]

TASK [sudmed.mongodb.mongo-backup : Check if backup user exists] *************************************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Create MongoDB user backup] **************************************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Copy backup script] **********************************************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Set up script on cron] *******************************************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Immediately backup standalone db stage_db2] **********************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Show results of immediately backup] ******************************************************************************************************************************************************
ok: [host1] => {
    "backup_result.stdout_lines": [
        "DB stage_db2 was backuped to: /usr/local/mongodb_backups/",
        "-e List of backups:",
        "stage_db2_202207021619.gz"
    ]
}

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=4    changed=2    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
```


---


### 4. Drop and Restore from backup

```bash
mongosh --port 28000 admin -u dbadmin -p
```
```bash
admin> use stage_db2
switched to db stage_db2
stage_db2> db.dropDatabase()
{ ok: 1, dropped: 'stage_db2' }
stage_db2> show dbs
admin        180.00 KiB
application   72.00 KiB
config       108.00 KiB
local         72.00 KiB
stage_db1    316.00 KiB
stage_db3    316.00 KiB
stage_db4    320.00 KiB
stage_db5    316.00 KiB
stage_db2> exit
```

`mongorestore --port=28000 -u=backup --gzip --drop --archive=stage_db2_202207021619.gz`

```bash
Enter password:

2022-07-02T16:27:56.120+0000    preparing collections to restore from
2022-07-02T16:27:56.125+0000    reading metadata for stage_db2.collection2 from archive 'stage_db2_202207021619.gz'
2022-07-02T16:27:56.125+0000    reading metadata for stage_db2.collection4 from archive 'stage_db2_202207021619.gz'
2022-07-02T16:27:56.125+0000    reading metadata for stage_db2.collection3 from archive 'stage_db2_202207021619.gz'
2022-07-02T16:27:56.125+0000    reading metadata for stage_db2.collection1 from archive 'stage_db2_202207021619.gz'
2022-07-02T16:27:56.138+0000    restoring stage_db2.collection3 from archive 'stage_db2_202207021619.gz'
2022-07-02T16:27:56.150+0000    restoring stage_db2.collection1 from archive 'stage_db2_202207021619.gz'
2022-07-02T16:27:56.168+0000    restoring stage_db2.collection2 from archive 'stage_db2_202207021619.gz'
2022-07-02T16:27:56.170+0000    finished restoring stage_db2.collection1 (1000 documents, 0 failures)
2022-07-02T16:27:56.170+0000    finished restoring stage_db2.collection3 (1000 documents, 0 failures)
2022-07-02T16:27:56.179+0000    finished restoring stage_db2.collection2 (1000 documents, 0 failures)
2022-07-02T16:27:56.207+0000    restoring stage_db2.collection4 from archive 'stage_db2_202207021619.gz'
2022-07-02T16:27:56.218+0000    finished restoring stage_db2.collection4 (1000 documents, 0 failures)
2022-07-02T16:27:56.218+0000    no indexes to restore for collection stage_db2.collection3
2022-07-02T16:27:56.218+0000    no indexes to restore for collection stage_db2.collection1
2022-07-02T16:27:56.218+0000    no indexes to restore for collection stage_db2.collection2
2022-07-02T16:27:56.218+0000    no indexes to restore for collection stage_db2.collection4
2022-07-02T16:27:56.218+0000    4000 document(s) restored successfully. 0 document(s) failed to restore.
```

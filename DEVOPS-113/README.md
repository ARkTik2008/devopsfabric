# DEVOPS-113 mongodb backup

В коллекцию [mongodb](/ansible/collections/ansible_collections/sudmed/mongodb/) добавлена новая роль `mongo-backup`. Роль выполняет три варианта резервного копирования:  
1. бэкап всех БД по крону раз в сутки (вариант по умолчанию).

2. бэкап одной определенной БД по крону раз в сутки, выполняется если задана переменная типа extra vars с названием `mongo_backup_db`, содержащая имя бэкапируемой БД:
```bash
playbook.yml --extra-vars "mongo_backup_db=DBname"
```

3. бэкап одной определенной БД немедленно, выполняется если задана переменная типа extra vars с названием `mongo_backup_now`, содержащая имя бэкапируемой БД:
```bash
playbook.yml --extra-vars "mongo_backup_now=DBname"
```

**Восстановление данных из бэкапа:**  
`mongorestore --port=28000 -u=backup --gzip --drop --archive=/path/to/db_file.gz`

---

## Validation 

### 1. Default backup (set to cron backing up all databases)

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

TASK [sudmed.mongodb.mongo-backup : Copy mongodb backup script for standalone db] ********************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Set up on cron daily mongo backup for standalone db] *************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Copy mongodb backup script for all dbs] **************************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Set up on cron daily mongo backup] *******************************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Immediately backup standalone db {{ mongo_backup_now }}] *********************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Show results of immediately backup] ******************************************************************************************************************************************************
skipping: [host1]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=4    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0
```

#### On Host1
`sudo crontab -l`  

```bash
#Ansible: Set up on cron daily mongo backup for all databases
15 0 * * * /usr/local/bin/mongodb_backup_all.sh > /dev/null 2>&1
```

`sudo /usr/local/bin/mongodb_backup_all.sh`  
```bash
2022-07-01T21:45:08.841+0000    writing admin.system.users to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.843+0000    done dumping admin.system.users (5 documents)
2022-07-01T21:45:08.843+0000    writing admin.system.version to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.844+0000    done dumping admin.system.version (3 documents)
2022-07-01T21:45:08.844+0000    writing application.mycollection to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.845+0000    writing stage_db1.collection3 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.847+0000    writing stage_db1.collection1 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.851+0000    writing stage_db1.collection2 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.861+0000    done dumping application.mycollection (1000 documents)
2022-07-01T21:45:08.861+0000    done dumping stage_db1.collection2 (1000 documents)
2022-07-01T21:45:08.861+0000    writing stage_db1.collection4 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.861+0000    writing stage_db2.collection3 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.865+0000    done dumping stage_db1.collection3 (1000 documents)
2022-07-01T21:45:08.865+0000    writing stage_db2.collection1 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.867+0000    done dumping stage_db1.collection1 (1000 documents)
2022-07-01T21:45:08.868+0000    writing stage_db2.collection2 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.870+0000    done dumping stage_db1.collection4 (1000 documents)
2022-07-01T21:45:08.870+0000    done dumping stage_db2.collection3 (1000 documents)
2022-07-01T21:45:08.871+0000    writing stage_db3.collection4 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.871+0000    writing stage_db2.collection4 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.881+0000    done dumping stage_db3.collection4 (1000 documents)
2022-07-01T21:45:08.881+0000    writing stage_db3.collection3 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.881+0000    done dumping stage_db2.collection2 (1000 documents)
2022-07-01T21:45:08.882+0000    writing stage_db3.collection2 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.885+0000    done dumping stage_db2.collection1 (1000 documents)
2022-07-01T21:45:08.886+0000    writing stage_db3.collection1 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.890+0000    done dumping stage_db3.collection3 (1000 documents)
2022-07-01T21:45:08.890+0000    writing stage_db4.collection2 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.896+0000    done dumping stage_db3.collection2 (1000 documents)
2022-07-01T21:45:08.897+0000    writing stage_db4.collection3 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.898+0000    done dumping stage_db2.collection4 (1000 documents)
2022-07-01T21:45:08.898+0000    writing stage_db4.collection4 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.899+0000    done dumping stage_db4.collection2 (1000 documents)
2022-07-01T21:45:08.899+0000    writing stage_db4.collection1 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.907+0000    done dumping stage_db3.collection1 (1000 documents)
2022-07-01T21:45:08.907+0000    writing stage_db5.collection2 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.909+0000    done dumping stage_db4.collection4 (1000 documents)
2022-07-01T21:45:08.909+0000    writing stage_db5.collection4 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.912+0000    done dumping stage_db4.collection1 (1000 documents)
2022-07-01T21:45:08.912+0000    done dumping stage_db4.collection3 (1000 documents)
2022-07-01T21:45:08.912+0000    writing stage_db5.collection1 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.913+0000    writing stage_db5.collection3 to archive 'all_dbs_202207012145.gz'
2022-07-01T21:45:08.921+0000    done dumping stage_db5.collection2 (1000 documents)
2022-07-01T21:45:08.923+0000    done dumping stage_db5.collection4 (1000 documents)
2022-07-01T21:45:08.923+0000    done dumping stage_db5.collection1 (1000 documents)
2022-07-01T21:45:08.924+0000    done dumping stage_db5.collection3 (1000 documents)
All dbs were backed up to: /usr/local/mongodb_backups/all_dbs/2022-07-01/
List of backups:
all_dbs_202207012145.gz
```

`ls -l /usr/local/mongodb_backups/all_dbs/2022-07-01/`  
```bash
total 428
-rw-r--r-- 1 root root 435066 Jul  1 21:45 all_dbs_202207012145.gz
```


---


### 2. Set to cron backing up a standalone db

```bash
ansible-playbook playbook-113.yml -u dmitriy --private-key /home/root1/.ssh/id_ed25519 -K -l host1 --extra-vars "mongo_backup_db=stage_db5"
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

TASK [sudmed.mongodb.mongo-backup : Copy mongodb backup script for standalone db] ********************************************************************************************************************************************
ok: [host1]

TASK [sudmed.mongodb.mongo-backup : Set up on cron daily mongo backup for standalone db] *************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Copy mongodb backup script for all dbs] **************************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Set up on cron daily mongo backup] *******************************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Immediately backup standalone db {{ mongo_backup_now }}] *********************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Show results of immediately backup] ******************************************************************************************************************************************************
skipping: [host1]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=4    changed=2    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0
```


### On host1
`sudo crontab -e`
```bash
#Ansible: Daily mongo backup stage_db5
15 0 * * * /usr/local/bin/mongodb_backup.sh stage_db5 > /dev/null 2>&1
```

`sudo /usr/local/bin/mongodb_backup.sh stage_db5`
```bash
2022-07-01T21:37:27.712+0000    writing stage_db5.collection4 to archive 'stage_db5_202207012137.gz'
2022-07-01T21:37:27.713+0000    writing stage_db5.collection3 to archive 'stage_db5_202207012137.gz'
2022-07-01T21:37:27.713+0000    writing stage_db5.collection1 to archive 'stage_db5_202207012137.gz'
2022-07-01T21:37:27.715+0000    writing stage_db5.collection2 to archive 'stage_db5_202207012137.gz'
2022-07-01T21:37:27.724+0000    done dumping stage_db5.collection1 (1000 documents)
2022-07-01T21:37:27.728+0000    done dumping stage_db5.collection3 (1000 documents)
2022-07-01T21:37:27.728+0000    done dumping stage_db5.collection4 (1000 documents)
2022-07-01T21:37:27.728+0000    done dumping stage_db5.collection2 (1000 documents)
DB stage_db5 was backed up to: /usr/local/mongodb_backups/stage_db5/2022-07-01/
List of backups:
stage_db5_202207012137.gz
stage_db5_202207012136.gz
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

TASK [sudmed.mongodb.mongo-backup : Copy mongodb backup script for standalone db] ********************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Set up on cron daily mongo backup for standalone db] *************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Copy mongodb backup script for all dbs] **************************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Set up on cron daily mongo backup] *******************************************************************************************************************************************************
skipping: [host1]

TASK [sudmed.mongodb.mongo-backup : Immediately backup standalone db stage_db2] **********************************************************************************************************************************************
changed: [host1]

TASK [sudmed.mongodb.mongo-backup : Show results of immediately backup] ******************************************************************************************************************************************************
ok: [host1] => {
    "backup_result.stdout_lines": [
        "DB stage_db2 was backed up to: /usr/local/mongodb_backups/stage_db2/",
        "-e List of backups:",
        "stage_db2_202207012056.gz"
    ]
}

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=4    changed=2    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0
```

### On host1
`ls -l /usr/local/mongodb_backups/stage_db2/`
```bash
total 84
-rw-r--r-- 1 root root 82916 Jul  1 20:56 stage_db2_202207012056.gz
```


### 4. Restore from backup

`mongorestore --port=28000 -u=backup --gzip --drop --archive=all_dbs_202207012145.gz`

```bash
Enter password:

2022-07-01T21:53:57.522+0000    preparing collections to restore from
2022-07-01T21:53:57.528+0000    reading metadata for stage_db1.collection4 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db3.collection4 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db4.collection4 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db5.collection2 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db2.collection2 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db3.collection1 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db4.collection2 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db4.collection3 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for application.mycollection from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db1.collection3 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db1.collection2 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db3.collection3 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db4.collection1 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db1.collection1 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db2.collection4 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.528+0000    reading metadata for stage_db2.collection3 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.529+0000    reading metadata for stage_db2.collection1 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.529+0000    reading metadata for stage_db3.collection2 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.529+0000    reading metadata for stage_db5.collection4 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.529+0000    reading metadata for stage_db5.collection1 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.529+0000    reading metadata for stage_db5.collection3 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.532+0000    dropping collection application.mycollection before restoring
2022-07-01T21:53:57.542+0000    restoring application.mycollection from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.552+0000    finished restoring application.mycollection (1000 documents, 0 failures)
2022-07-01T21:53:57.553+0000    dropping collection stage_db1.collection2 before restoring
2022-07-01T21:53:57.564+0000    restoring stage_db1.collection2 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.577+0000    finished restoring stage_db1.collection2 (1000 documents, 0 failures)
2022-07-01T21:53:57.577+0000    dropping collection stage_db1.collection3 before restoring
2022-07-01T21:53:57.588+0000    restoring stage_db1.collection3 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.599+0000    finished restoring stage_db1.collection3 (1000 documents, 0 failures)
2022-07-01T21:53:57.599+0000    dropping collection stage_db1.collection1 before restoring
2022-07-01T21:53:57.611+0000    restoring stage_db1.collection1 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.623+0000    finished restoring stage_db1.collection1 (1000 documents, 0 failures)
2022-07-01T21:53:57.623+0000    dropping collection stage_db1.collection4 before restoring
2022-07-01T21:53:57.636+0000    restoring stage_db1.collection4 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.649+0000    finished restoring stage_db1.collection4 (1000 documents, 0 failures)
2022-07-01T21:53:57.649+0000    dropping collection stage_db2.collection3 before restoring
2022-07-01T21:53:57.658+0000    restoring stage_db2.collection3 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.669+0000    finished restoring stage_db2.collection3 (1000 documents, 0 failures)
2022-07-01T21:53:57.669+0000    dropping collection stage_db2.collection1 before restoring
2022-07-01T21:53:57.677+0000    restoring stage_db2.collection1 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.681+0000    dropping collection stage_db3.collection4 before restoring
2022-07-01T21:53:57.690+0000    restoring stage_db3.collection4 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.692+0000    dropping collection stage_db2.collection2 before restoring
2022-07-01T21:53:57.703+0000    restoring stage_db2.collection2 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.706+0000    finished restoring stage_db3.collection4 (1000 documents, 0 failures)
2022-07-01T21:53:57.706+0000    finished restoring stage_db2.collection1 (1000 documents, 0 failures)
2022-07-01T21:53:57.714+0000    finished restoring stage_db2.collection2 (1000 documents, 0 failures)
2022-07-01T21:53:57.714+0000    dropping collection stage_db3.collection3 before restoring
2022-07-01T21:53:57.722+0000    restoring stage_db3.collection3 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.734+0000    finished restoring stage_db3.collection3 (1000 documents, 0 failures)
2022-07-01T21:53:57.735+0000    dropping collection stage_db2.collection4 before restoring
2022-07-01T21:53:57.743+0000    restoring stage_db2.collection4 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.747+0000    dropping collection stage_db3.collection2 before restoring
2022-07-01T21:53:57.759+0000    restoring stage_db3.collection2 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.760+0000    finished restoring stage_db2.collection4 (1000 documents, 0 failures)
2022-07-01T21:53:57.769+0000    finished restoring stage_db3.collection2 (1000 documents, 0 failures)
2022-07-01T21:53:57.770+0000    dropping collection stage_db4.collection2 before restoring
2022-07-01T21:53:57.779+0000    restoring stage_db4.collection2 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.790+0000    finished restoring stage_db4.collection2 (1000 documents, 0 failures)
2022-07-01T21:53:57.790+0000    dropping collection stage_db3.collection1 before restoring
2022-07-01T21:53:57.798+0000    restoring stage_db3.collection1 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.800+0000    dropping collection stage_db4.collection1 before restoring
2022-07-01T21:53:57.813+0000    restoring stage_db4.collection1 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.815+0000    finished restoring stage_db3.collection1 (1000 documents, 0 failures)
2022-07-01T21:53:57.816+0000    dropping collection stage_db4.collection4 before restoring
2022-07-01T21:53:57.825+0000    restoring stage_db4.collection4 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.836+0000    finished restoring stage_db4.collection4 (1000 documents, 0 failures)
2022-07-01T21:53:57.836+0000    dropping collection stage_db4.collection3 before restoring
2022-07-01T21:53:57.845+0000    restoring stage_db4.collection3 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.848+0000    finished restoring stage_db4.collection1 (1000 documents, 0 failures)
2022-07-01T21:53:57.856+0000    finished restoring stage_db4.collection3 (1000 documents, 0 failures)
2022-07-01T21:53:57.857+0000    dropping collection stage_db5.collection2 before restoring
2022-07-01T21:53:57.865+0000    restoring stage_db5.collection2 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.868+0000    dropping collection stage_db5.collection4 before restoring
2022-07-01T21:53:57.879+0000    restoring stage_db5.collection4 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.882+0000    finished restoring stage_db5.collection2 (1000 documents, 0 failures)
2022-07-01T21:53:57.882+0000    dropping collection stage_db5.collection1 before restoring
2022-07-01T21:53:57.908+0000    restoring stage_db5.collection1 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.911+0000    finished restoring stage_db5.collection4 (1000 documents, 0 failures)
2022-07-01T21:53:57.921+0000    finished restoring stage_db5.collection1 (1000 documents, 0 failures)
2022-07-01T21:53:57.921+0000    dropping collection stage_db5.collection3 before restoring
2022-07-01T21:53:57.930+0000    restoring stage_db5.collection3 from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.943+0000    finished restoring stage_db5.collection3 (1000 documents, 0 failures)
2022-07-01T21:53:57.943+0000    restoring users from archive 'all_dbs_202207012145.gz'
2022-07-01T21:53:57.958+0000    no indexes to restore for collection stage_db3.collection2
2022-07-01T21:53:57.958+0000    no indexes to restore for collection stage_db4.collection4
2022-07-01T21:53:57.958+0000    no indexes to restore for collection stage_db4.collection2
2022-07-01T21:53:57.958+0000    no indexes to restore for collection stage_db4.collection3
2022-07-01T21:53:57.958+0000    no indexes to restore for collection stage_db4.collection1
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db5.collection4
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db5.collection1
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db5.collection3
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db5.collection2
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db2.collection3
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db2.collection1
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db2.collection2
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db2.collection4
2022-07-01T21:53:57.959+0000    no indexes to restore for collection application.mycollection
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db1.collection3
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db3.collection4
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db1.collection1
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db1.collection4
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db3.collection1
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db3.collection3
2022-07-01T21:53:57.959+0000    no indexes to restore for collection stage_db1.collection2
2022-07-01T21:53:57.959+0000    21000 document(s) restored successfully. 0 document(s) failed to restore.
```

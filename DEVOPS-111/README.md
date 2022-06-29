# DEVOPS-092 rabbitmq ansible collection

## Pre-requisties

`Set up vars by direnv`

```console
cd ansible
echo export ANSIBLE_VAULT_PASSWORD_FILE="/mnt/c/UbuntuServer/ansible_vault/.ansible_vault_pass" > .envrc
echo export ANSIBLE_CONFIG=./ansible.cfg >> .envrc
direnv allow
```


## 0. Description of configuration
* Установлен другой порт (28000) в качестве порта по умолчанию.  
* Включена аутентификация по паролю (`authorization:enabled`).  
* Отключены `FreeMonitoring` и `Telemetry`.
* Создан администратор `admin` для создания учетных записей других пользователей, не может управлять БД или выполнять другие задачи управления.  
* Создан администратор баз данных `dbadmin`, имеет доступ ко всем БД в системе, может создавать новые БД, управлять кластерами MongoDB и наборами реплик.  
* Создан рядовой пользователь `dbuser` с правами readWrite на базу `application`.  


---


## 1. Play ansible playbook - 1st run

`ansible-playbook playbook-111.yml -u dmitriy --private-key /home/root1/.ssh/id_ed25519 -K`

```yaml
BECOME password:

PLAY [Deploy MongoDB] ********************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************************
ok: [host3]
ok: [host1]
ok: [host2]

TASK [sudmed.mongodb.mongo-setup : Check if gnupg installed] *****************************************************************************************************************************************************************
ok: [host3]
ok: [host1]
ok: [host2]

TASK [sudmed.mongodb.mongo-setup : Add apt signing key] **********************************************************************************************************************************************************************
ok: [host3]
changed: [host1]
changed: [host2]

TASK [sudmed.mongodb.mongo-setup : Add Yandex mirror MongoDB repository] *****************************************************************************************************************************************************
ok: [host3]
changed: [host1]
changed: [host2]

TASK [sudmed.mongodb.mongo-setup : Install standalone node MongoDB] **********************************************************************************************************************************************************
changed: [host3]
changed: [host2]
changed: [host1]

TASK [sudmed.mongodb.mongo-setup : Change MongoDB default port] **************************************************************************************************************************************************************
changed: [host2]
changed: [host1]
changed: [host3]

TASK [sudmed.mongodb.mongo-setup : Flush handlers] ***************************************************************************************************************************************************************************

RUNNING HANDLER [sudmed.mongodb.mongo-setup : start mongodb] *****************************************************************************************************************************************************************
changed: [host3]
changed: [host1]
changed: [host2]

RUNNING HANDLER [sudmed.mongodb.mongo-setup : restart mongodb] ***************************************************************************************************************************************************************
changed: [host2]
changed: [host1]
changed: [host3]

TASK [sudmed.mongodb.mongo-setup : Disable MongoDB FreeMonitoring & Telemetry] ***********************************************************************************************************************************************
changed: [host3]
changed: [host2]
changed: [host1]

TASK [sudmed.mongodb.mongo-setup : Create MongoDB user admin] ****************************************************************************************************************************************************************
changed: [host1]
changed: [host3]
changed: [host2]

TASK [sudmed.mongodb.mongo-setup : Enable Authentication on MongoDB] *********************************************************************************************************************************************************
changed: [host1]
changed: [host2]
changed: [host3]

TASK [sudmed.mongodb.mongo-setup : Create MongoDB user dbadmin] **************************************************************************************************************************************************************
changed: [host1]
changed: [host2]
changed: [host3]

TASK [sudmed.mongodb.mongo-setup : Create MongoDB ordinary user] *************************************************************************************************************************************************************
changed: [host1]
changed: [host3]
changed: [host2]

RUNNING HANDLER [sudmed.mongodb.mongo-setup : restart mongodb] ***************************************************************************************************************************************************************
changed: [host1]
changed: [host2]
changed: [host3]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=14   changed=12   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host2                      : ok=14   changed=12   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host3                      : ok=14   changed=10   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```


## 2. Play ansible playbook - 2nd run

`ansible-playbook playbook-111.yml -u dmitriy --private-key /home/root1/.ssh/id_ed25519 -K`

```yaml
BECOME password:

PLAY [Deploy MongoDB] ********************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************************
ok: [host2]
ok: [host1]
ok: [host3]

TASK [sudmed.mongodb.mongo-setup : Check if gnupg installed] *****************************************************************************************************************************************************************
ok: [host3]
ok: [host1]
ok: [host2]

TASK [sudmed.mongodb.mongo-setup : Add apt signing key] **********************************************************************************************************************************************************************
ok: [host3]
ok: [host2]
ok: [host1]

TASK [sudmed.mongodb.mongo-setup : Add Yandex mirror MongoDB repository] *****************************************************************************************************************************************************
ok: [host2]
ok: [host1]
ok: [host3]

TASK [sudmed.mongodb.mongo-setup : Install standalone node MongoDB] **********************************************************************************************************************************************************
ok: [host2]
ok: [host3]
ok: [host1]

TASK [sudmed.mongodb.mongo-setup : Change MongoDB default port] **************************************************************************************************************************************************************
ok: [host1]
ok: [host2]
ok: [host3]

TASK [sudmed.mongodb.mongo-setup : Flush handlers] ***************************************************************************************************************************************************************************

TASK [sudmed.mongodb.mongo-setup : Disable MongoDB FreeMonitoring & Telemetry] ***********************************************************************************************************************************************
changed: [host2]
changed: [host1]
changed: [host3]

TASK [sudmed.mongodb.mongo-setup : Create MongoDB user admin] ****************************************************************************************************************************************************************
changed: [host1]
changed: [host2]
changed: [host3]

TASK [sudmed.mongodb.mongo-setup : Enable Authentication on MongoDB] *********************************************************************************************************************************************************
ok: [host1]
ok: [host2]
ok: [host3]

TASK [sudmed.mongodb.mongo-setup : Create MongoDB user dbadmin] **************************************************************************************************************************************************************
changed: [host1]
changed: [host2]
changed: [host3]

TASK [sudmed.mongodb.mongo-setup : Create MongoDB ordinary user] *************************************************************************************************************************************************************
changed: [host1]
changed: [host2]
changed: [host3]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=11   changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host2                      : ok=11   changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host3                      : ok=11   changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```


## 3. Validation on Host1  

** `mongosh --port 28000 admin -u admin` **

```yaml
Enter password: ********************************************************************************************************************************
Current Mongosh Log ID: 62bcad497cfe9b8f656cb7df
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/admin?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

admin> show dbs
admin   116.00 KiB
config   12.00 KiB
local    72.00 KiB
admin> show users
[
  {
    _id: 'admin.admin',
    userId: UUID("234aba3f-7849-4332-b226-dd76ee31b42a"),
    user: 'admin',
    db: 'admin',
    roles: [ { role: 'userAdminAnyDatabase', db: 'admin' } ],
    mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
  },
  {
    _id: 'admin.dbadmin',
    userId: UUID("65e99aca-b067-4b6a-82db-4d89a8bab79d"),
    user: 'dbadmin',
    db: 'admin',
    roles: [
      { role: 'dbAdminAnyDatabase', db: 'admin' },
      { role: 'clusterAdmin', db: 'admin' },
      { role: 'readWriteAnyDatabase', db: 'admin' }
    ],
    mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
  }
]
admin>
```


** `mongosh --port 28000 admin -u dbadmin` **

```yaml
Enter password: ********************************************************************************************************************************
Current Mongosh Log ID: 62bcadaa5c0a64139f6effce
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/admin?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2022-06-29T19:47:03.326+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
------

admin> show dbs
admin   116.00 KiB
config   60.00 KiB
local    72.00 KiB
admin> show users
MongoServerError: not authorized on admin to execute command { usersInfo: 1, lsid: { id: UUID("e1aa47eb-9c87-401d-b0a0-98d9af57f412") }, $db: "admin" }
admin> use application
switched to db application
application>
```


** `mongosh --port 28000 application -u dbuser` **

```yaml
Enter password: ********************
Current Mongosh Log ID: 62bcae4e8cc0e0d39c50d96a
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/application?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

application> show dbs

application> db.mycollection.insertOne({"name":"ranjeet", "description":"How to enable security using SCRAM-SH1 mechanism"});
{
  acknowledged: true,
  insertedId: ObjectId("62bcae7c0a559779af74119e")
}
application> db.mycollection.find();
[
  {
    _id: ObjectId("62bcae7c0a559779af74119e"),
    name: 'ranjeet',
    description: 'How to enable security using SCRAM-SH1 mechanism'
  }
]
application> show dbs
application  8.00 KiB
application>
```

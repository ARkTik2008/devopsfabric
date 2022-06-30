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
ok: [host1]
ok: [host2]
ok: [host3]

TASK [sudmed.mongodb.mongo-setup : Add Yandex mirror MongoDB repository] *****************************************************************************************************************************************************
ok: [host3]
ok: [host2]
ok: [host1]

TASK [sudmed.mongodb.mongo-setup : Install standalone node MongoDB] **********************************************************************************************************************************************************
changed: [host1]
changed: [host3]
changed: [host2]

TASK [sudmed.mongodb.mongo-setup : Flush handlers at this point] *************************************************************************************************************************************************************

RUNNING HANDLER [sudmed.mongodb.mongo-setup : start mongodb] *****************************************************************************************************************************************************************
changed: [host2]
changed: [host1]
changed: [host3]

TASK [sudmed.mongodb.mongo-setup : Enable mongod service on startup] *********************************************************************************************************************************************************
ok: [host2]
ok: [host1]
ok: [host3]

TASK [sudmed.mongodb.mongo-setup : Check if user admin exists] ***************************************************************************************************************************************************************
fatal: [host2]: FAILED! => {"changed": true, "cmd": ["mongosh", "--port", "28000", "admin", "-u", "admin", "-p", "NmUzNjUwY2ZmNWY5YmNiYTk1ZjI1OWZjOWVhMzVlZDYwMDdjNTE0NzQ1MTUwZjNhYWQyYWZjMjkxNWEzOTRiNDljZGNhMDllOTA3M2NjZGMyY2U4MGY1NjI5M2MwMTVk", "--eval", "db.runCommand({ connectionStatus : 1 })"], "delta": "0:00:00.720095", "end": "2022-06-30 12:19:16.203901", "msg": "non-zero return code", "rc": 1, "start": "2022-06-30 12:19:15.483806", "stderr": "MongoNetworkError: connect ECONNREFUSED 127.0.0.1:28000", "stderr_lines": ["MongoNetworkError: connect ECONNREFUSED 127.0.0.1:28000"], "stdout": "Current Mongosh Log ID:\t62bd94c48e3db460bf440f00\nConnecting to:\t\tmongodb://<credentials>@127.0.0.1:28000/admin?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0", "stdout_lines": ["Current Mongosh Log ID:\t62bd94c48e3db460bf440f00", "Connecting to:\t\tmongodb://<credentials>@127.0.0.1:28000/admin?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0"]}
...ignoring
fatal: [host1]: FAILED! => {"changed": true, "cmd": ["mongosh", "--port", "28000", "admin", "-u", "admin", "-p", "NmUzNjUwY2ZmNWY5YmNiYTk1ZjI1OWZjOWVhMzVlZDYwMDdjNTE0NzQ1MTUwZjNhYWQyYWZjMjkxNWEzOTRiNDljZGNhMDllOTA3M2NjZGMyY2U4MGY1NjI5M2MwMTVk", "--eval", "db.runCommand({ connectionStatus : 1 })"], "delta": "0:00:00.743275", "end": "2022-06-30 12:19:16.227372", "msg": "non-zero return code", "rc": 1, "start": "2022-06-30 12:19:15.484097", "stderr": "MongoNetworkError: connect ECONNREFUSED 127.0.0.1:28000", "stderr_lines": ["MongoNetworkError: connect ECONNREFUSED 127.0.0.1:28000"], "stdout": "Current Mongosh Log ID:\t62bd94c4e7701564d63100eb\nConnecting to:\t\tmongodb://<credentials>@127.0.0.1:28000/admin?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0", "stdout_lines": ["Current Mongosh Log ID:\t62bd94c4e7701564d63100eb", "Connecting to:\t\tmongodb://<credentials>@127.0.0.1:28000/admin?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0"]}
...ignoring
fatal: [host3]: FAILED! => {"changed": true, "cmd": ["mongosh", "--port", "28000", "admin", "-u", "admin", "-p", "NmUzNjUwY2ZmNWY5YmNiYTk1ZjI1OWZjOWVhMzVlZDYwMDdjNTE0NzQ1MTUwZjNhYWQyYWZjMjkxNWEzOTRiNDljZGNhMDllOTA3M2NjZGMyY2U4MGY1NjI5M2MwMTVk", "--eval", "db.runCommand({ connectionStatus : 1 })"], "delta": "0:00:00.787207", "end": "2022-06-30 12:19:16.282779", "msg": "non-zero return code", "rc": 1, "start": "2022-06-30 12:19:15.495572", "stderr": "MongoNetworkError: connect ECONNREFUSED 127.0.0.1:28000", "stderr_lines": ["MongoNetworkError: connect ECONNREFUSED 127.0.0.1:28000"], "stdout": "Current Mongosh Log ID:\t62bd94c426bcf731b7c74ce2\nConnecting to:\t\tmongodb://<credentials>@127.0.0.1:28000/admin?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0", "stdout_lines": ["Current Mongosh Log ID:\t62bd94c426bcf731b7c74ce2", "Connecting to:\t\tmongodb://<credentials>@127.0.0.1:28000/admin?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0"]}
...ignoring

TASK [sudmed.mongodb.mongo-setup : Create MongoDB user admin] ****************************************************************************************************************************************************************
changed: [host2]
changed: [host3]
changed: [host1]

TASK [sudmed.mongodb.mongo-setup : Create MongoDB user dbadmin] **************************************************************************************************************************************************************
changed: [host3]
changed: [host2]
changed: [host1]

TASK [sudmed.mongodb.mongo-setup : Create MongoDB ordinary user] *************************************************************************************************************************************************************
changed: [host2]
changed: [host1]
changed: [host3]

TASK [sudmed.mongodb.mongo-setup : Set configuration file] *******************************************************************************************************************************************************************
changed: [host2]
changed: [host1]
changed: [host3]

TASK [sudmed.mongodb.mongo-setup : Flush handlers at this point] *************************************************************************************************************************************************************

RUNNING HANDLER [sudmed.mongodb.mongo-setup : restart mongodb] ***************************************************************************************************************************************************************
changed: [host2]
changed: [host1]
changed: [host3]

TASK [sudmed.mongodb.mongo-setup : Disable MongoDB FreeMonitoring & Telemetry] ***********************************************************************************************************************************************
changed: [host1]
changed: [host3]
changed: [host2]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=14   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1
host2                      : ok=14   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1
host3                      : ok=14   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1
```


## 2. Play ansible playbook - 2nd run

`ansible-playbook playbook-111.yml -u dmitriy --private-key /home/root1/.ssh/id_ed25519 -K`

```yaml
BECOME password:

PLAY [Deploy MongoDB] ********************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************************
ok: [host1]
ok: [host3]
ok: [host2]

TASK [sudmed.mongodb.mongo-setup : Check if gnupg installed] *****************************************************************************************************************************************************************
ok: [host1]
ok: [host2]
ok: [host3]

TASK [sudmed.mongodb.mongo-setup : Add apt signing key] **********************************************************************************************************************************************************************
ok: [host1]
ok: [host2]
ok: [host3]

TASK [sudmed.mongodb.mongo-setup : Add Yandex mirror MongoDB repository] *****************************************************************************************************************************************************
ok: [host3]
ok: [host2]
ok: [host1]

TASK [sudmed.mongodb.mongo-setup : Install standalone node MongoDB] **********************************************************************************************************************************************************
ok: [host2]
ok: [host1]
ok: [host3]

TASK [sudmed.mongodb.mongo-setup : Flush handlers at this point] *************************************************************************************************************************************************************

TASK [sudmed.mongodb.mongo-setup : Enable mongod service on startup] *********************************************************************************************************************************************************
ok: [host3]
ok: [host1]
ok: [host2]

TASK [sudmed.mongodb.mongo-setup : Check if user admin exists] ***************************************************************************************************************************************************************
changed: [host3]
changed: [host2]
changed: [host1]

TASK [sudmed.mongodb.mongo-setup : Create MongoDB user admin] ****************************************************************************************************************************************************************
skipping: [host1]
skipping: [host2]
skipping: [host3]

TASK [sudmed.mongodb.mongo-setup : Create MongoDB user dbadmin] **************************************************************************************************************************************************************
skipping: [host1]
skipping: [host2]
skipping: [host3]

TASK [sudmed.mongodb.mongo-setup : Create MongoDB ordinary user] *************************************************************************************************************************************************************
skipping: [host1]
skipping: [host2]
skipping: [host3]

TASK [sudmed.mongodb.mongo-setup : Set configuration file] *******************************************************************************************************************************************************************
ok: [host3]
ok: [host1]
ok: [host2]

TASK [sudmed.mongodb.mongo-setup : Flush handlers at this point] *************************************************************************************************************************************************************

TASK [sudmed.mongodb.mongo-setup : Disable MongoDB FreeMonitoring & Telemetry] ***********************************************************************************************************************************************
changed: [host2]
changed: [host3]
changed: [host1]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=9    changed=2    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
host2                      : ok=9    changed=2    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
host3                      : ok=9    changed=2    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
```


## 3. Validation on Host1  

**`mongosh --port 28000 admin -u admin -p`**

```yaml
Enter password: ********************************************************************************************************************************
Current Mongosh Log ID: 62bd9be6fc9995a98959ef32
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/admin?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

admin> show users
[
  {
    _id: 'admin.admin',
    userId: UUID("439ed953-8cac-4894-95ba-74138cb327e9"),
    user: 'admin',
    db: 'admin',
    roles: [ { role: 'userAdminAnyDatabase', db: 'admin' } ],
    mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
  },
  {
    _id: 'admin.dbadmin',
    userId: UUID("03190a46-9250-4f06-81b7-f75dc6fbaa2c"),
    user: 'dbadmin',
    db: 'admin',
    roles: [
      { role: 'readWriteAnyDatabase', db: 'admin' },
      { role: 'dbAdminAnyDatabase', db: 'admin' },
      { role: 'clusterAdmin', db: 'admin' }
    ],
    mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
  }
]
admin>
admin> show dbs
admin        132.00 KiB
application   40.00 KiB
config       108.00 KiB
local         72.00 KiB
admin>
```


**`mongosh --port 28000 admin -u dbadmin -p`**

```yaml

Enter password: ********************************************************************************************************************************
Current Mongosh Log ID: 62bd9c26ceaa289d6f247d3f
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/admin?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2022-06-30T12:19:22.005+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
------

admin> show users
MongoServerError: not authorized on admin to execute command { usersInfo: 1, lsid: { id: UUID("17cf440b-d5ca-4976-8005-710098c0fdbe") }, $db: "admin" }
admin>

admin> show dbs
admin        132.00 KiB
application   40.00 KiB
config       108.00 KiB
local         72.00 KiB
admin>
admin> use application
switched to db application
application>
```


**`mongosh --port 28000 application -u dbuser`**

```yaml
Enter password: ********************
Current Mongosh Log ID: 62bd9c7b74076bf39f9681c0
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/application?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

application> show dbs
application  40.00 KiB
application>
application> db.mycollection.insertOne({"name":"ranjeet", "description":"How to enable security using SCRAM-SH1 mechanism"});
{
  acknowledged: true,
  insertedId: ObjectId("62bd9cbe8a0d53e9f612ef07")
}
application>
application> db.mycollection.find();
[
  {
    _id: ObjectId("62bd9cbe8a0d53e9f612ef07"),
    name: 'ranjeet',
    description: 'How to enable security using SCRAM-SH1 mechanism'
  }
]
application>
application> show dbs
application  80.00 KiB
application>
```

  
### One-liner 'Hello World'
`mongosh --port 28000 application -u dbuser -p --eval 'db.application.insertOne({ "speech" : "Hello World!" }); cur = db.application.find();x=cur.next();print(x["speech"]);'`

```yaml
Current Mongosh Log ID: 62bd9ac63fd42cef86005ba2
Connecting to:          mongodb://<credentials>@127.0.0.1:28000/application?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.5.0
Using MongoDB:          5.0.9
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

Hello World!

```

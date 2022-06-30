# DEVOPS-101 redis setup

## 1. Ansible collection

### 1.1. Collection `sudmed.redis` is located 
  [\ansible\collections\ansible_collections\sudmed\redis](/ansible/collections/ansible_collections/sudmed/redis/)

### 1.2. Collection is called from playbook named `playbook-101.yml`
  [\ansible\playbook-101.yml](/ansible/playbook-101.yml)

### 1.3. Command for running
`ansible-playbook playbook-101.yml -u dmitriy --private-key /home/root1/.ssh/id_ed25519 -K`

### 1.4. Results of 1st playing
```console
BECOME password:

PLAY [Deploy Redis] **********************************************************************************************************************************************************************************************************

TASK [sudmed.redis.redis : Add Redis repo] ***********************************************************************************************************************************************************************************
changed: [host1]
changed: [host3]
changed: [host2]

TASK [sudmed.redis.redis : Install Redis server] *****************************************************************************************************************************************************************************
changed: [host1]
changed: [host3]
changed: [host2]

TASK [sudmed.redis.redis : Start and enable Redis] ***************************************************************************************************************************************************************************
ok: [host2]
ok: [host3]
ok: [host1]

TASK [sudmed.redis.redis : Secure Redis with a strong password] **************************************************************************************************************************************************************
changed: [host1]
changed: [host2]
changed: [host3]

TASK [sudmed.redis.redis : Modify The Redis Persistence Mode (add AOF)] ******************************************************************************************************************************************************
changed: [host1]
changed: [host2]
changed: [host3]

TASK [sudmed.redis.redis : Modify The Redis Persistence Mode] ****************************************************************************************************************************************************************
changed: [host1]
changed: [host2]
changed: [host3]

RUNNING HANDLER [sudmed.redis.redis : Restart Redis] *************************************************************************************************************************************************************************
changed: [host2]
changed: [host1]
changed: [host3]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=7    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host2                      : ok=7    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host3                      : ok=7    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 1.5. Results of 2nd playing
```console
BECOME password:

PLAY [Deploy Redis] **********************************************************************************************************************************************************************************************************

TASK [sudmed.redis.redis : Add Redis repo] ***********************************************************************************************************************************************************************************
changed: [host2]
changed: [host1]
changed: [host3]

TASK [sudmed.redis.redis : Install Redis server] *****************************************************************************************************************************************************************************
ok: [host1]
ok: [host3]
ok: [host2]

TASK [sudmed.redis.redis : Start and enable Redis] ***************************************************************************************************************************************************************************
ok: [host1]
ok: [host3]
ok: [host2]

TASK [sudmed.redis.redis : Secure Redis with a strong password] **************************************************************************************************************************************************************
ok: [host2]
ok: [host1]
ok: [host3]

TASK [sudmed.redis.redis : Modify The Redis Persistence Mode (add AOF)] ******************************************************************************************************************************************************
ok: [host1]
ok: [host2]
ok: [host3]

TASK [sudmed.redis.redis : Modify The Redis Persistence Mode] ****************************************************************************************************************************************************************
ok: [host1]
ok: [host2]
ok: [host3]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=6    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host2                      : ok=6    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host3                      : ok=6    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## 2. Redis persistence
[Redis manual](https://redis.io/docs/manual/persistence/) is clear about it: the general indication is to use both persistence methods AOF and RDB. When Redis restarts, the AOF file will be used to reconstruct original dataset since it is guaranteed to be the most complete.

**Persistence AOF+RDB in config file**:  
`sudo cat /etc/redis/redis.conf |  egrep "^save|^append"`

```console
save 3600 1 300 100 60 10000
appendonly yes
appendfilename "appendonly.aof"
appenddirname "appendonlydir"
appendfsync everysec
```


## 3. Shell script

Script generates 10K random pairs "key-value" and inserts them on Redis server.  
Example of generated data: key=`3796HafI` value=`jmr+6TOPamceIOx28ogfByoS7+v`.  

#### Pre-requisites
Load `REDISCLI_AUTH` environment variable for Redis authorization with `direnv` extension.  

```console
cd DEVOPS-101
echo export REDISCLI_AUTH="tVdpa0RvtxhU389kLe4NKTFrFyqqETN96vm2ynaC6b6xzeIRGDRoczUzlvNOM/FgK979/6siTj7wmrjL" > .envrc
direnv allow
```

#### [Script](/DEVOPS-101/redis_generator.sh)

#### Running script
`./redis_generator.sh`
```console
OK
31521Hf+ PhWjAWQq
OK
8818Ztc 0ZvvaXTWh9RsbR8lMnlv9e/YgqjQD39Qhg/Ep04cDzt
OK
217210Cu5h bl/
OK
23574LfploJHbcy gEJwFV4qUolWJGraxDrkSOHSWIKFXuplaYJf5Gq4dwd
OK
384363OLIsxIa GoZsrmGJnKu4Eo/AuHl5K3/BRVk6RPriTUNmD29dw0dEDc
OK
3055744Pq rpoaonj9PI8wuQ+XL4d+gSI8wAdz9YnoJQJsEOHoPu
OK
22044t5S q+KN
OK
4450/hfl lzrCtYqWQyKdKL8Y6qtfY+SDdWv/qRq
OK
31077eBuaTwCO Xca3m/trILM4CMkwBTeiNpji6UriB6I+yDi7KKCP/KX
OK
16385kgt v9ox4NdBsuE+wx+PVfiXdTu+E2Ud
OK
24493s 93nuOJL1
OK
172872Ci4E hp5x7uY3AN/RYKb584I3goA
OK
19887jWSX87Sg eAZvWKw2s5iN6Oi84UHRZuueT3iRWDjdQ7XLGxS
<...>
```

#### Results
`redis-cli info keyspace`
```console
# Keyspace
db0:keys=10000,expires=0,avg_ttl=0
```


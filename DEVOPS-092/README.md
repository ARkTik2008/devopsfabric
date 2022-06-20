# DEVOPS-092 rabbitmq ansible collection

## Pre-requisties

`Set up vars by direnv`

```console
cd ansible
echo export ANSIBLE_VAULT_PASSWORD_FILE="/mnt/c/UbuntuServer/ansible_vault/.ansible_vault_pass" > .envrc
echo export ANSIBLE_CONFIG=./ansible.cfg >> .envrc
direnv allow
```


## Play ansible playbook

Host1 and host2 just played.

`ansible-playbook playbook-092-c.yml -u dmitriy --private-key /home/root1/.ssh/id_ed25519 -K`

```yaml
BECOME password:

PLAY [Deploy RabbitMQ] *******************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************************
ok: [host3]
ok: [host2]
ok: [host1]

TASK [sudmed.rabbitmq.rabbitmq : Add erlang repository from RabbitMQ team] ***************************************************************************************************************************************************
ok: [host2]
ok: [host1]
ok: [host3]

TASK [sudmed.rabbitmq.rabbitmq : Install erlang] *****************************************************************************************************************************************************************************
ok: [host1]
ok: [host2]
changed: [host3]

TASK [sudmed.rabbitmq.rabbitmq : Install RabbitMQ server] ********************************************************************************************************************************************************************
ok: [host1]
ok: [host2]
changed: [host3]

TASK [sudmed.rabbitmq.rabbitmq : Copy rabbitmq config file] ******************************************************************************************************************************************************************
ok: [host1]
ok: [host2]
changed: [host3]

TASK [sudmed.rabbitmq.rabbitmq : Start and enable rabbitmq] ******************************************************************************************************************************************************************
ok: [host2]
ok: [host1]
ok: [host3]

TASK [sudmed.rabbitmq.rabbitmq : wait_for] ***********************************************************************************************************************************************************************************
ok: [host1]
ok: [host3]
ok: [host2]

TASK [sudmed.rabbitmq.rabbitmq : Add vhosts to rabbitmq] *********************************************************************************************************************************************************************
changed: [host2] => (item=rabbitmqctl add_vhost appa)
changed: [host1] => (item=rabbitmqctl add_vhost appa)
changed: [host3] => (item=rabbitmqctl add_vhost appa)
changed: [host1] => (item=rabbitmqctl add_vhost appb)
changed: [host2] => (item=rabbitmqctl add_vhost appb)
changed: [host3] => (item=rabbitmqctl add_vhost appb)
changed: [host1] => (item=rabbitmqctl add_vhost appc)
changed: [host2] => (item=rabbitmqctl add_vhost appc)
changed: [host3] => (item=rabbitmqctl add_vhost appc)

TASK [sudmed.rabbitmq.rabbitmq : Check if user exists] ***********************************************************************************************************************************************************************
changed: [host2]
changed: [host3]
changed: [host1]

TASK [sudmed.rabbitmq.rabbitmq : Add user appa to rabbitmq] ******************************************************************************************************************************************************************
skipping: [host1]
skipping: [host2]
changed: [host3]

TASK [sudmed.rabbitmq.rabbitmq : Add user appb to rabbitmq] ******************************************************************************************************************************************************************
skipping: [host1]
skipping: [host2]
changed: [host3]

TASK [sudmed.rabbitmq.rabbitmq : Add user appc to rabbitmq] ******************************************************************************************************************************************************************
skipping: [host1]
skipping: [host2]
changed: [host3]

TASK [sudmed.rabbitmq.rabbitmq : Set permissions to rabbitmq] ****************************************************************************************************************************************************************
changed: [host1] => (item=rabbitmqctl set_permissions -p appa appa ".*" ".*" ".*")
changed: [host2] => (item=rabbitmqctl set_permissions -p appa appa ".*" ".*" ".*")
changed: [host3] => (item=rabbitmqctl set_permissions -p appa appa ".*" ".*" ".*")
changed: [host1] => (item=rabbitmqctl set_permissions -p appb appb ".*" ".*" ".*")
changed: [host2] => (item=rabbitmqctl set_permissions -p appb appb ".*" ".*" ".*")
changed: [host3] => (item=rabbitmqctl set_permissions -p appb appb ".*" ".*" ".*")
changed: [host1] => (item=rabbitmqctl set_permissions -p appc appc ".*" ".*" ".*")
changed: [host2] => (item=rabbitmqctl set_permissions -p appc appc ".*" ".*" ".*")
changed: [host3] => (item=rabbitmqctl set_permissions -p appc appc ".*" ".*" ".*")

RUNNING HANDLER [sudmed.rabbitmq.rabbitmq : Restart rabbitmq] ****************************************************************************************************************************************************************
changed: [host3]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=10   changed=3    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
host2                      : ok=10   changed=3    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
host3                      : ok=14   changed=10   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
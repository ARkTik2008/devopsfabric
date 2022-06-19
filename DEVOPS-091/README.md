# DEVOPS-091 ansible setup

## List of files:
### 1. ansible/hosts
Ansible inventiry file, in INI format, contains 3 hosts for running commands and playbooks. As being in custom location, it needs to be listed in ansible configuration file.  
Please note, that host1 already has a modified sshd port from one of previous task.

### 2. ansible/ansible.cfg
Ansible configuration file, in INI format, contains some basic default values: the path to an inventory file, and the path to a vault password file. As being in custom location, it requires to be specified in an environment variable 'ANSIBLE_CONFIG'.

### 3. ansible/ansible_vault_pass
Vault password file, contains the password for decrypting strings from ansible vault in non-interactive mode. It is ignored by Git via .gitignore file.

### 4. ansible/group_vars/ubuntu_hosts AND ansible/group_vars/all
Variables for host groups 'ubuntu_hosts' and 'all', moved from the inventory file for simplicity and easy to recognize. The file 'group_vars/ubuntu_hosts' comtains 2 encrypted vars: 'admin_password' and 'ansible_become_pass'.


### 5. ansible/playbook_DEVOPS-091.yml
Ansible playbook file, contains 2 main tasks: change sshd port and add user.

### 6. DEVOPS-091/README.md
this file.

---

## Pre-requisties

`Set up vars by direnv`

```console
cd ansible
echo export ANSIBLE_VAULT_PASSWORD_FILE="/mnt/c/UbuntuServer/ansible_vault/.ansible_vault_pass" > .envrc
echo export ANSIBLE_CONFIG=./ansible.cfg >> .envrc
direnv allow
```


## First run

`ansible-playbook playbook-091.yml -u dmitriy --private-key /home/root1/.ssh/id_ed25519 -K`

```console
BECOME password:

PLAY [Change sshd port and add user] *****************************************************************************************************************************************************************************************

TASK [Change sshd port if var 'use_custom_ssh_port' is true] *****************************************************************************************************************************************************************
changed: [host3]
changed: [host2]
ok: [host1]

TASK [Add user 'admin' with password from secret variable] *******************************************************************************************************************************************************************
changed: [host1]
changed: [host3]
changed: [host2]

RUNNING HANDLER [Restart sshd] ***********************************************************************************************************************************************************************************************
changed: [host2]
changed: [host3]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host2                      : ok=3    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host3                      : ok=3    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```


## Second and subsequent runs

`ansible-playbook playbook-091.yml -u dmitriy --private-key /home/root1/.ssh/id_ed25519 -K -e 'ansible_ssh_port=222'`

```console
BECOME password:

PLAY [Change sshd port and add user] *****************************************************************************************************************************************************************************************

TASK [Change sshd port if var 'use_custom_ssh_port' is true] *****************************************************************************************************************************************************************
ok: [host1]
ok: [host2]
ok: [host3]

TASK [Add user 'admin' with password from secret variable] *******************************************************************************************************************************************************************
changed: [host1]
changed: [host2]
changed: [host3]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host2                      : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host3                      : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```


## Validation
`ansible-inventory --graph`
```console
@all:
  |--@devenv:
  |  |--host2
  |--@rabbitmqservers:
  |  |--host2
  |--@ubuntu_hosts:
  |  |--host1
  |  |--host2
  |  |--host3
  |--@ungrouped:
  |--@webservers:
  |  |--host2
```

`ansible-inventory --list`
```console
{
    "_meta": {
        "hostvars": {
            "host1": {
                "ANSIBLE_HOST_KEY_CHECKING": false,
                "admin_password": "{{ vault_admin_password }}",
                "ansible_host": "192.168.88.111",
                "ansible_port": 222,
                "use_custom_ssh_port": true,
                "vault_admin_password": "\\'LXyRKXVXehs2YE!R\\\"jvizKwz!"
            },
            "host2": {
                "ANSIBLE_HOST_KEY_CHECKING": false,
                "admin_password": "{{ vault_admin_password }}",
                "ansible_host": "192.168.88.108",
                "use_custom_ssh_port": true,
                "vault_admin_password": "\\'LXyRKXVXehs2YE!R\\\"jvizKwz!"
            },
            "host3": {
                "ANSIBLE_HOST_KEY_CHECKING": false,
                "admin_password": "{{ vault_admin_password }}",
                "ansible_host": "192.168.88.107",
                "use_custom_ssh_port": true,
                "vault_admin_password": "\\'LXyRKXVXehs2YE!R\\\"jvizKwz!"
            }
        }
    },
    "all": {
        "children": [
            "devenv",
            "rabbitmqservers",
            "ubuntu_hosts",
            "ungrouped",
            "webservers"
        ]
    },
    "devenv": {
        "hosts": [
            "host2"
        ]
    },
    "rabbitmqservers": {
        "hosts": [
            "host2"
        ]
    },
    "ubuntu_hosts": {
        "hosts": [
            "host1",
            "host2",
            "host3"
        ]
    },
    "webservers": {
        "hosts": [
            "host2"
        ]
    }
}
```


## Results of playing playbook
`cat /etc/ssh/sshd_config | grep ^Port`
```console
Port 222
```

`cat /etc/passwd | grep ^admin`
```console
admin:x:1005:1005:Added by Ansible:/home/admin:/bin/bash
```
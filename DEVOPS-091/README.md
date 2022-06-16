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

`export ANSIBLE_CONFIG=./ansible.cfg`


## Run

`ansible-playbook playbook_DEVOPS-091.yml`

```console
PLAY [Change sshd port and add user] *****************************************************************************************************************************************************************************************

TASK [Change sshd port if var 'use_custom_ssh_port' is true] *****************************************************************************************************************************************************************
ok: [host1]
changed: [host2]
changed: [host3]

TASK [Set variable for use in password hashing below] ************************************************************************************************************************************************************************
ok: [host1]
ok: [host2]
ok: [host3]

TASK [Add user 'admin' with password from secret variable] *******************************************************************************************************************************************************************
changed: [host1]
changed: [host3]
changed: [host2]

RUNNING HANDLER [Restart sshd] ***********************************************************************************************************************************************************************************************
changed: [host2]
changed: [host3]

PLAY RECAP *******************************************************************************************************************************************************************************************************************
host1                      : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host2                      : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
host3                      : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
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
                "admin_password": {
                    "__ansible_vault": "$ANSIBLE_VAULT;1.1;AES256\n31393338313261656161386235336635666334326336326135353437363137393234323036343932\n3139356365393864636135623534663237386166663864330a383333393833326136656261343964\n32663236613865376433326266366566386462336262336237663663346361326635636132383261\n6662336636396335310a383833323261393863616538613435306336653435613438653632326639\n31653138623661323439646535343832653735646562633362346265393462613366\n"
                },
                "ansible_become_pass": {
                    "__ansible_vault": "$ANSIBLE_VAULT;1.1;AES256\n38666462343266383732653133346635316362323737353265373965616365663934333030386339\n6437396535633631613032326161373862626161306566640a613434333262393838343234393230\n36303439343238636239383662656262643534353664646363623832643335383935643166363038\n3865656632643431620a616565336530363862613233333037363061623764373064653439353236\n3533"
                },
                "ansible_host": "192.168.88.111",
                "ansible_port": 222,
                "ansible_ssh_private_key_file": "/home/root1/.ssh/id_ed25519",
                "ansible_user": "dmitriy",
                "use_custom_ssh_port": true
            },
            "host2": {
                "ANSIBLE_HOST_KEY_CHECKING": false,
                "admin_password": {
                    "__ansible_vault": "$ANSIBLE_VAULT;1.1;AES256\n31393338313261656161386235336635666334326336326135353437363137393234323036343932\n3139356365393864636135623534663237386166663864330a383333393833326136656261343964\n32663236613865376433326266366566386462336262336237663663346361326635636132383261\n6662336636396335310a383833323261393863616538613435306336653435613438653632326639\n31653138623661323439646535343832653735646562633362346265393462613366\n"
                },
                "ansible_become_pass": {
                    "__ansible_vault": "$ANSIBLE_VAULT;1.1;AES256\n38666462343266383732653133346635316362323737353265373965616365663934333030386339\n6437396535633631613032326161373862626161306566640a613434333262393838343234393230\n36303439343238636239383662656262643534353664646363623832643335383935643166363038\n3865656632643431620a616565336530363862613233333037363061623764373064653439353236\n3533"
                },
                "ansible_host": "192.168.88.108",
                "ansible_ssh_private_key_file": "/home/root1/.ssh/id_ed25519",
                "ansible_user": "dmitriy",
                "use_custom_ssh_port": true
            },
            "host3": {
                "ANSIBLE_HOST_KEY_CHECKING": false,
                "admin_password": {
                    "__ansible_vault": "$ANSIBLE_VAULT;1.1;AES256\n31393338313261656161386235336635666334326336326135353437363137393234323036343932\n3139356365393864636135623534663237386166663864330a383333393833326136656261343964\n32663236613865376433326266366566386462336262336237663663346361326635636132383261\n6662336636396335310a383833323261393863616538613435306336653435613438653632326639\n31653138623661323439646535343832653735646562633362346265393462613366\n"
                },
                "ansible_become_pass": {
                    "__ansible_vault": "$ANSIBLE_VAULT;1.1;AES256\n38666462343266383732653133346635316362323737353265373965616365663934333030386339\n6437396535633631613032326161373862626161306566640a613434333262393838343234393230\n36303439343238636239383662656262643534353664646363623832643335383935643166363038\n3865656632643431620a616565336530363862613233333037363061623764373064653439353236\n3533"
                },
                "ansible_host": "192.168.88.107",
                "ansible_ssh_private_key_file": "/home/root1/.ssh/id_ed25519",
                "ansible_user": "dmitriy",
                "use_custom_ssh_port": true
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


## Results of executing playbook on all Hosts are idempotent
`cat /etc/ssh/sshd_config | grep ^Port`
```console
Port 222
```

`cat /etc/passwd | grep ^admin`
```console
admin:x:1005:1005:Added by Ansible:/home/admin:/bin/bash
```
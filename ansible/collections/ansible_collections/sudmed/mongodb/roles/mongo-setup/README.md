Role Name
=========

This role installs and configures MongoDB Community Edition.


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

---
- name: Deploy MongoDB
  hosts: all
  gather_facts: yes
  become: yes
  
  collections:
  - sudmed.mongodb

  tasks:
    - import_role:
        name: mongo-setup
...


License
-------

BSD

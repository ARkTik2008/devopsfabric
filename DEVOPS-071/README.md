# DEVOPS-071  custom service

## List of files:

### 1. tail_passwd.sh
shell script to be deamonize.
### 2. tail_deamonizer.sh
shell script that deamonizes the first one.
### 3. tail_passwd.service
systemd service unit configuration file.
### 4. README.md
this file.

---

## Validating the task

### 1. Running processes

`ps -eF | grep tail`

```console
root        1881       1  0  1743  3332   0 17:54 ?        00:00:00 /bin/bash /opt/tail_passwd.sh
root        1882    1881  0  1378   584   1 17:54 ?        00:00:00 tail -f /etc/passwd
```


### 2. Running processes as a tree

`pstree`

```console
systemd─┬─ModemManager───2*[{ModemManager}]
        ├─accounts-daemon───2*[{accounts-daemon}]
        ├─agetty
        ├─atd
        ├─containerd───7*[{containerd}]
        ├─cron
        ├─dbus-daemon
        ├─dockerd───13*[{dockerd}]
        ├─irqbalance───{irqbalance}
        ├─multipathd───6*[{multipathd}]
        ├─networkd-dispat
        ├─nginx───2*[nginx]
        ├─polkitd───2*[{polkitd}]
        ├─rsyslogd───3*[{rsyslogd}]
        ├─snapd───10*[{snapd}]
        ├─sshd───sshd───sshd───bash───sudo───bash───pstree
        ├─systemd───(sd-pam)
        ├─systemd-journal
        ├─systemd-logind
        ├─systemd-network
        ├─systemd-resolve
        ├─systemd-timesyn───{systemd-timesyn}
        ├─systemd-udevd
        ├─tail_passwd.sh───tail
        ├─udisksd───4*[{udisksd}]
        └─unattended-upgr───{unattended-upgr}
```


### 3. Restarting daemon

`ps -eF | grep tail_`

```console
root        2128       1  0  1743  3400   1 18:05 ?        00:00:00 /bin/bash /opt/tail_passwd.sh
```

`kill -KILL 2128`
```console
#
```

`ps -eF | grep tail_`
```console
#
```

`ps -eF | grep tail_`
```console
root        2174       1  0  1743  3384   1 18:06 ?        00:00:00 /bin/bash /opt/tail_passwd.sh
```


### 4. Logs

`ll /var/log/ | grep tail_`

```console
-rw-r--r--   1 root      root                  0 May 31 17:54 tail_passwd_stderr.log
-rw-r--r--   1 root      root                580 May 31 17:54 tail_passwd_stdout.log
```

`cat /var/log/tail_passwd_stdout.log`

```console
usbmux:x:111:46:usbmux daemon,,,:/var/lib/usbmux:/usr/sbin/nologin
sshd:x:112:65534::/run/sshd:/usr/sbin/nologin
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
dmitriy:x:1000:1000:Dmitriy:/home/dmitriy:/bin/bash
lxd:x:998:100::/var/snap/lxd/common/lxd:/bin/false
dpashkov:x:1001:1001:Dmitry Pashkov:/home/dpashkov:/bin/bash
sdogg:x:1002:1002:Snoop Dogg:/home/sdogg:/bin/bash
bmarley:x:1003:1003:Bob Marley:/home/bmarley:/bin/bash
monitoring:x:1004:1004:monitoring:/home/monitoring:/usr/bin/custom_shell.sh
nginx:x:113:117:nginx user,,,:/nonexistent:/bin/false
usbmux:x:111:46:usbmux daemon,,,:/var/lib/usbmux:/usr/sbin/nologin
sshd:x:112:65534::/run/sshd:/usr/sbin/nologin
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
dmitriy:x:1000:1000:Dmitriy:/home/dmitriy:/bin/bash
lxd:x:998:100::/var/snap/lxd/common/lxd:/bin/false
dpashkov:x:1001:1001:Dmitry Pashkov:/home/dpashkov:/bin/bash
sdogg:x:1002:1002:Snoop Dogg:/home/sdogg:/bin/bash
bmarley:x:1003:1003:Bob Marley:/home/bmarley:/bin/bash
monitoring:x:1004:1004:monitoring:/home/monitoring:/usr/bin/custom_shell.sh
nginx:x:113:117:nginx user,,,:/nonexistent:/bin/false
usbmux:x:111:46:usbmux daemon,,,:/var/lib/usbmux:/usr/sbin/nologin
sshd:x:112:65534::/run/sshd:/usr/sbin/nologin
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
dmitriy:x:1000:1000:Dmitriy:/home/dmitriy:/bin/bash
lxd:x:998:100::/var/snap/lxd/common/lxd:/bin/false
dpashkov:x:1001:1001:Dmitry Pashkov:/home/dpashkov:/bin/bash
sdogg:x:1002:1002:Snoop Dogg:/home/sdogg:/bin/bash
bmarley:x:1003:1003:Bob Marley:/home/bmarley:/bin/bash
monitoring:x:1004:1004:monitoring:/home/monitoring:/usr/bin/custom_shell.sh
nginx:x:113:117:nginx user,,,:/nonexistent:/bin/false
usbmux:x:111:46:usbmux daemon,,,:/var/lib/usbmux:/usr/sbin/nologin
sshd:x:112:65534::/run/sshd:/usr/sbin/nologin
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
dmitriy:x:1000:1000:Dmitriy:/home/dmitriy:/bin/bash
lxd:x:998:100::/var/snap/lxd/common/lxd:/bin/false
dpashkov:x:1001:1001:Dmitry Pashkov:/home/dpashkov:/bin/bash
sdogg:x:1002:1002:Snoop Dogg:/home/sdogg:/bin/bash
bmarley:x:1003:1003:Bob Marley:/home/bmarley:/bin/bash
monitoring:x:1004:1004:monitoring:/home/monitoring:/usr/bin/custom_shell.sh
nginx:x:113:117:nginx user,,,:/nonexistent:/bin/false
usbmux:x:111:46:usbmux daemon,,,:/var/lib/usbmux:/usr/sbin/nologin
sshd:x:112:65534::/run/sshd:/usr/sbin/nologin
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
dmitriy:x:1000:1000:Dmitriy:/home/dmitriy:/bin/bash
lxd:x:998:100::/var/snap/lxd/common/lxd:/bin/false
dpashkov:x:1001:1001:Dmitry Pashkov:/home/dpashkov:/bin/bash
sdogg:x:1002:1002:Snoop Dogg:/home/sdogg:/bin/bash
bmarley:x:1003:1003:Bob Marley:/home/bmarley:/bin/bash
monitoring:x:1004:1004:monitoring:/home/monitoring:/usr/bin/custom_shell.sh
nginx:x:113:117:nginx user,,,:/nonexistent:/bin/false
```


### 5. Is enabled, loaded, active

`systemctl is-enabled tail_passwd.service`

```console
enabled
```


`systemctl list-units | grep tail`

```console
tail_passwd.service 		loaded active running   Small script to watching for list of the system’s accounts.
```


`systemctl list-units -t service | grep tail`

```console
tail_passwd.service		loaded active running Small script to watching for list of the system’s accounts.
```

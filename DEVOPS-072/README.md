# DEVOPS-072 cron exercise
## List of files:

### 1. add_cronjobs.sh
Bash script to add jobs to cron.
### 2. cronjob1
1st cronjob that should start at 4.00 am on Saturdays.
### 3. cronjob2
2nd cronjob that should start at system startup.
### 4. cronjob3
3rd cronjob that should start every 3 hours.
### 5. cronjob4
4th cronjob that should start every 10 seconds.
### 5. README.md
this file.

---

## Bash script to add cronjobs
Simply copies 4 separate cronjob files to /etc/cron.d/ directory, and make them not executable and not writable by `group` or `other` (as [manpage](https://manpages.ubuntu.com/manpages/focal/man8/cron.8.html) writes).

```console
cp -f cronjob* /etc/cron.d/
chmod 600 /etc/cron.d/cronjob*
```

## Cronjob files
The `echo` command is selected as an example of run payload for cron job. For clear logging the execution of last cronjob, we will use `tee` command. For simplicity, there will be the same command for all tasks:

```console
echo `date` | tee -a /var/log/cronjob{1..4}.log
```

---

## Task validation
**Cronjob4**
```bash
tail -F /var/log/cronjob4.log
```
```console
Wed 01 Jun 2022 08:53:01 PM UTC
Wed 01 Jun 2022 08:53:11 PM UTC
Wed 01 Jun 2022 08:53:21 PM UTC
Wed 01 Jun 2022 08:53:31 PM UTC
Wed 01 Jun 2022 08:53:41 PM UTC
Wed 01 Jun 2022 08:53:51 PM UTC
Wed 01 Jun 2022 08:54:01 PM UTC
Wed 01 Jun 2022 08:54:11 PM UTC
Wed 01 Jun 2022 08:54:21 PM UTC
```

```bash
grep CRON /var/log/syslog
```
```console
Jun  1 20:53:01 ubuntu CRON[4621]: (root) CMD (sleep 40 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
Jun  1 20:53:01 ubuntu CRON[4622]: (root) CMD (sleep 50 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
Jun  1 20:53:01 ubuntu CRON[4624]: (root) CMD (sleep 30 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
Jun  1 20:53:01 ubuntu CRON[4627]: (root) CMD (sleep 20 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
Jun  1 20:53:01 ubuntu CRON[4629]: (root) CMD (sleep 10 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
Jun  1 20:53:01 ubuntu CRON[4631]: (root) CMD (sleep  0 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
Jun  1 20:53:01 ubuntu CRON[4620]: (CRON) info (No MTA installed, discarding output)
Jun  1 20:53:11 ubuntu CRON[4619]: (CRON) info (No MTA installed, discarding output)
Jun  1 20:53:21 ubuntu CRON[4618]: (CRON) info (No MTA installed, discarding output)
Jun  1 20:53:31 ubuntu CRON[4617]: (CRON) info (No MTA installed, discarding output)
Jun  1 20:53:41 ubuntu CRON[4616]: (CRON) info (No MTA installed, discarding output)
Jun  1 20:53:51 ubuntu CRON[4615]: (CRON) info (No MTA installed, discarding output)
Jun  1 20:54:01 ubuntu CRON[4667]: (root) CMD (sleep  0 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
Jun  1 20:54:01 ubuntu CRON[4669]: (root) CMD (sleep 10 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
Jun  1 20:54:01 ubuntu CRON[4668]: (root) CMD (sleep 50 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
Jun  1 20:54:01 ubuntu CRON[4670]: (root) CMD (sleep 20 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
Jun  1 20:54:01 ubuntu CRON[4679]: (root) CMD (sleep 40 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
Jun  1 20:54:01 ubuntu CRON[4673]: (root) CMD (sleep 30 ; ( echo `date` | tee -a /var/log/cronjob4.log ))
```


**Cronjob3**
```bash
tail -F /var/log/cronjob3.log
```
```console
Wed 01 Jun 2022 09:00:01 PM UTC
```

**Cronjob2**
```bash
reboot
...
tail -F /var/log/cronjob2.log
```
```console
Wed 01 Jun 2022 09:30:36 PM UTC
```

## Where does cron search for crontab files?

1. /var/spool/cron/crontabs
2. /etc/crontab
3. /etc/cron.d
4. /etc/cron.{hourly,daily,weekly,monthly}


# DEVOPS-006 bash and basic monitoring


**Screenshot of running tmux session** (system is idle)
![tmux panes](/DEVOPS-006/tmux_screen.png)

The script 'tmux_starter.sh' creates tmux session named 'monitoring' with 3 panes, and starts 
'tee_exec_script.sh' script in each pane respectively with 3 different arguments: "ps auxww", "top" 
and "vmstat 5".

When the system doesn't perform any processes, the script shows monitored values close to zero.

The system has 2 CPU cores:
```bash
at /proc/cpuinfo | grep "cpu cores"
cpu cores       : 1
cpu cores       : 1
```


**Screenshot of running tmux session** (file generating script is running)
![file generating script is running](/DEVOPS-006/file-gen.png)

When we run the script 'files_generator.sh' that generates random files, we can see a slight 
increase of the values of 1 minute LA (0,08), %us (10.0), %sy (31.2), %wa (1.0) and decrease of the 
value of %id (52.4). This indicates that the system load is small, the performance margin is high.

---

**Screenshot of running tmux session** (backup script is running)
![file generating script is running](/DEVOPS-006/backup.png)

When we run the backup script 'backup.sh', we can see greater increase in values 
of 1 minute LA (0,34), %us (25.6), %sy (4.8), %wa (6.1) and decrease of the value of %id (56.3).
This means that archiving and compression are more resource-intensive tasks. However, the system 
load is still low and the performance margin is still high.

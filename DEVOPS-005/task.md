*Задача  DEVOPS-005 Git branching*  
 
В этой задаче мы играем в одновременную работу двух людей над одной задачей.  
- Нужно склонировать тестовый гит репозиторий в домашние директории пользователей Bob и Snoop.  
- Под Bob сделать ветку DEVOPS-005-bob-git-branching.  
- Запушить в эту ветку файл DEVOPS-005/gitenv.md в котором описать как сконфигурировать гит автора и гит емайл используя переменные окружения. Эти коммиты должны иметь авторство Боба в истории коммитов.  
- Запушить отдельным коммитом файл DEVOPS-005/cheat-sheet.md с перечислением самых полезных на ваш взгляд git команд.  
- Под Snoop сделать ветку  DEVOPS-005-snoop-git-branching ИЗ ВЕТКИ  DEVOPS-005-bob-git-branching. В нем в том же  файле DEVOPS-005/gitenv.md добавить команды как сконфигурироать гит автора и емайл для коммита от имени Snoop Dogg. в файле DEVOPS-005/cheat-sheet.md добавить еще пару строк с самыми полезными командами vim.  
- Сделать PR из обоих веток в вашу дефолтную ветку, запросить ревью.  
- После ревью мною будет сделан squash merge PR из ветку DEVOPS-005-bob-git-branching. Это сделает conflict в PR из ветки DEVOPS-005-snoop-git-branching.  
- Нужно исправить эти конфликты из консоли ( не из UI Github) и запросить повторное ревью.  

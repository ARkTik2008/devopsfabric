## Задача DEVOPS-092 rabbitmq ansible collection
 
Нужно написать ansible  коллекцию, которая:  
- Устанавливает rabbitmq.  
- Добавляет vhosts:  
  - appa,  
  - appb,  
  - appc.  
- Добавляет пользователей appa, appb и appc имеющих доступ только в свой vhost.  
- Устанавливает memory watermark в 60% от размера оперативной памяти.  
 
Обращаю внимание что здесь и далее мы предусматриваем два сценария выполнения:  
1. Первоначальная настройка на чистой системе.  
2. Выполнение на уже настроенной системе, которое будет переконфигурировать что-то, только если конфигурация не совпадает.  
Все переменные должны иметь настройки по умолчанию. Код не должен заваливаться если мы не установили какие-то настройки в групповых переменных или в переменных хоста.  

PR должен содержать сам код, интеграцию коллекции в предыдущую структуру файлов с использованием переменных этой коллекции и вывод запуска на чистой и уже настроенных системах.  

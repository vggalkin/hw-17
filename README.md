# Использование

## Перед использованием настраиваем ssh подключение к серверу для хранения бэкапов без пароля

### Далее

```bash
sudo cp mysql_backup.sh /usr/local/bin/mysql_backup.sh
sudo chmod +x /usr/local/bin/mysql_backup.sh
```
### Заполняем mysql_backup.config своими значениями и копируем в директорию /etc/

```bash
sudo cp mysql_backup.config /etc/mysql_backup.conf
crontab -e
```

### Добавляем задание
```
# Ежедневно в 2:00 ночи
0 2 * * * /usr/local/bin/mysql_backup_simple.sh
```

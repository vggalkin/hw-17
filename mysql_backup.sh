#!/bin/bash

# Загружаем настройки из файла
CONFIG_FILE="mysql_backup.conf"
if [ -f "$CONFIG_FILE" ]; then
    source $CONFIG_FILE
else
    echo "Ошибка. Отсутствует файл конфигурации!"
fi

# Дата для имени файла
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_backup_$DATE.sql.gz"

# Создаем директорию если нет
mkdir -p $BACKUP_DIR

# Создаем бэкап
echo "Создаем бэкап базы данных $DB_NAME..."
mysqldump -u$DB_USER -p$DB_PASS $DB_NAME | gzip > $BACKUP_FILE

# Проверяем успешность создания
if [ $? -eq 0 ]; then
    echo "Бэкап создан: $BACKUP_FILE"
    
    # Отправляем на удаленный сервер
    echo "Отправляем на удаленный сервер..."
    scp $BACKUP_FILE $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/
    
    if [ $? -eq 0 ]; then
        echo "Бэкап успешно отправлен на $REMOTE_HOST"
    else
        echo "Ошибка при отправке на удаленный сервер"
    fi
else
    echo "Ошибка при создании бэкапа"
fi

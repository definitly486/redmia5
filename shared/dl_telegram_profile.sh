#!/system/bin/sh

# Проверяем наличие введенного пароля
if [ -z "$1" ]; then
    echo "не введен пароль для распаковки telegram"
    exit 1
fi

PASSWORD="$1" # сохраняем пароль в отдельной переменной

# Скачиваем зашифрованный архив, если его ещё нет
if ! [ -f "td.binlog.tar.xz.enc" ]; then
    curl -k -L -o td.binlog.tar.xz.enc \
        https://github.com/definitly486/Lenovo_Tab_3_7_TB3-730X/releases/download/shared/td.binlog.tar.xz.enc
fi

# Используем экранирование пароля с помощью printf
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -d \
    -in td.binlog.tar.xz.enc \
    -out td.binlog.tar.xz \
    -pass pass:$PASSWORD

# Извлекаем содержимое архива
busybox tar xfJ td.binlog.tar.xz

# Определяем ID пользователя приложения Challegram
ID=$(su - root -c "ls -l /data/data/ | grep chall | head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "chown $ID:$ID td.binlog"
su - root -c "rm /data/data/org.thunderdog.challegram/files/tdlib/td.binlog"
su - root -c "cp td.binlog /data/data/org.thunderdog.challegram/files/tdlib/"
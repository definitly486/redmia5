#!/system/bin/sh

# Проверяем наличие введенного пароля
if [ -z "$1" ]; then
    echo "не введен пароль для распаковки telegram"
    exit 1
fi

PASSWORD="$1" # сохраняем пароль в отдельной переменной

# Скачиваем зашифрованный архив, если его ещё нет
if ! [ -f "com.qflair.browserq.tar.enc" ]; then
    curl -k -L -o com.qflair.browserq.tar.enc \
       https://github.com/definitly486/redmia5/releases/download/shared/com.qflair.browserq.tar.enc
fi

# Используем экранирование пароля с помощью printf
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -d \
    -in com.qflair.browserq.tar.enc  \
    -out com.qflair.browserq.tar \
    -pass pass:$PASSWORD

# Извлекаем содержимое архива
su - root -c "rm -R com.qflair.browserq"
busybox tar xf com.qflair.browserq.tar

# Определяем ID пользователя приложения com.qflair.browserq
ID=$(su - root -c "ls -l /data/data/ | grep qflair | head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "cp -R  com.qflair.browserq  /data/data/"
su - root -c "chown -R  $ID:$ID /data/data/com.qflair.browserq"
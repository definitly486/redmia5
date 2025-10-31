#!/system/bin/sh

# Проверяем наличие введенного пароля
if [ -z "$1" ]; then
    echo "не введен пароль для распаковки telegram"
    exit 1
fi

PASSWORD="$1" # сохраняем пароль в отдельной переменной

# Скачиваем зашифрованный архив, если его ещё нет
if ! [ -f "com.fsck.k9.tar.enc" ]; then
    curl -k -L -o com.fsck.k9.tar.enc \
       https://github.com/definitly486/redmia5/releases/download/shared/com.fsck.k9.tar.enc
fi

# Используем экранирование пароля с помощью printf
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -d \
    -in com.fsck.k9.tar.enc  \
    -out com.fsck.k9.tar \
    -pass pass:$PASSWORD

# Извлекаем содержимое архива
su - root -c "rm -R  com.fsck.k9"
busybox tar xf com.fsck.k9.tar
# Определяем ID пользователя приложения com.fsck.k9
ID=$(su - root -c "ls -l /data/data/ | grep k9 | head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "cp -R  com.fsck.k9  /data/data/"
su - root -c "chown -R  $ID:$ID /data/data/com.fsck.k9"
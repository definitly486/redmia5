#!/system/bin/sh

# Проверяем наличие введенного пароля
if [ -z "$1" ]; then
    echo "не введен пароль для распаковки telegram"
    exit 1
fi

PASSWORD="$1" # сохраняем пароль в отдельной переменной

# Скачиваем зашифрованный архив, если его ещё нет
if ! [ -f "com.bin.dev.tar.enc" ]; then
    curl -k -L -o com.bin.dev.tar.enc \
       https://github.com/definitly486/redmia5/releases/download/shared/com.bin.dev.tar.enc
fi

# Используем экранирование пароля с помощью printf
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -d \
    -in com.bin.dev.tar.enc  \
    -out com.bin.dev.tar \
    -pass pass:$PASSWORD

# Извлекаем содержимое архива
su - root -c "rm -R com.binance.dev"
busybox tar xf com.bin.dev.tar

# Определяем ID пользователя приложения com.qflair.browserq
ID=$(su - root -c "ls -l /data/data/ | grep bina | head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "cp -R  com.binance.dev  /data/data/"
su - root -c "chown -R  $ID:$ID /data/data/com.binance.dev"
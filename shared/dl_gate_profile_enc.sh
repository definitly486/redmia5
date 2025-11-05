#!/system/bin/sh

# Проверяем наличие введенного пароля
if [ -z "$1" ]; then
    echo "не введен пароль для распаковки gateio"
    exit 1
fi

PASSWORD="$1" # сохраняем пароль в отдельной переменной

# Скачиваем зашифрованный архив, если его ещё нет
if ! [ -f "com.gateio.gateio.tar.enc" ]; then
    curl -k -L -o com.gateio.gateio.tar.enc \
       https://github.com/definitly486/redmia5/releases/download/shared/com.gateio.gateio.tar.enc


# Используем экранирование пароля с помощью printf
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -d \
    -in com.gateio.gateio.tar.enc  \
    -out com.gateio.gateio.tar \
    -pass pass:$PASSWORD

# Извлекаем содержимое архива
su - root -c "rm -R com.gateio.gateio"
busybox tar xf com.gateio.gateio.tar

# Определяем ID пользователя приложения gateio
ID=$(su - root -c "ls -l /data/data/ | grep gateio| head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "cp -R  com.gateio.gateio  /data/data/"
su - root -c "chown -R  $ID:$ID /data/data/com.gateio.gateio/"
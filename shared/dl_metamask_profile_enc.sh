#!/system/bin/sh

# Проверяем наличие введенного пароля
if [ -z "$1" ]; then
    echo "не введен пароль для распаковки gateio"
    exit 1
fi

PASSWORD="$1" # сохраняем пароль в отдельной переменной

# Скачиваем зашифрованный архив, если его ещё нет
if ! [ -f "io.metamask.tar.enc" ]; then
    curl -k -L -o io.metamask.tar.enc \
       https://github.com/definitly486/redmia5/releases/download/shared/io.metamask.tar.enc
fi

# Используем экранирование пароля с помощью printf
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -d \
    -in io.metamask.tar.enc  \
    -out io.metamask.tar \
    -pass pass:$PASSWORD

# Извлекаем содержимое архива
su - root -c "rm -R  io.metamask"

busybox tar xf  io.metamask.tar

# Определяем ID пользователя приложения gateio
ID=$(su - root -c "ls -l /data/data/ | grep metamask | head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "cp -R  io.metamask  /data/data/"
su - root -c "chown -R  $ID:$ID /data/data/io.metamask/"
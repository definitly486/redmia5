#!/system/bin/sh

# Проверяем наличие введенного пароля
if [ -z "$1" ]; then
    echo "не введен пароль для распаковки cherrygram"
    exit 1
fi

PASSWORD="$1" # сохраняем пароль в отдельной переменной

# Скачиваем зашифрованный архив, если его ещё нет
if ! [ -f "ru.oneme.app.tar.enc" ]; then
    curl -k -L -o ru.oneme.app.tar.enc \
       https://github.com/definitly486/redmia5/releases/download/shared/ru.oneme.app.tar.enc
fi

# Используем экранирование пароля с помощью printf
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -d \
    -in  ru.oneme.app.tar.enc \
    -out ru.oneme.app.tar \
    -pass pass:"$PASSWORD"

# Извлекаем содержимое архива
su - root -c "rm -R ru.oneme.app"
busybox tar xf ru.oneme.app.tar

# Определяем ID пользователя приложения Challegram
ID=$(su - root -c "ls -l /data/data/ | grep oneme | head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "rm -R /data/data/ru.oneme.app"
su - root -c "cp -R ru.oneme.app /data/data/"
su - root -c "chown -R \"$ID\":$ID /data/data/ru.oneme.app"
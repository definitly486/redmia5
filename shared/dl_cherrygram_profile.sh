#!/system/bin/sh

# Проверяем наличие введенного пароля
if [ -z "$1" ]; then
    echo "не введен пароль для распаковки cherrygram"
    exit 1
fi

PASSWORD="$1" # сохраняем пароль в отдельной переменной

# Скачиваем зашифрованный архив, если его ещё нет
if ! [ -f "uz.unnarsx.cherrygram.tar.enc" ]; then
    curl -k -L -o uz.unnarsx.cherrygram.tar.enc \
       https://github.com/definitly486/redmia5/releases/download/shared/uz.unnarsx.cherrygram.tar.enc
fi

# Используем экранирование пароля с помощью printf
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -d \
    -in  uz.unnarsx.cherrygram.tar.enc \
    -out uz.unnarsx.cherrygram.tar \
    -pass pass:$PASSWORD

# Извлекаем содержимое архива
su - root -c "rm -R "uz.unnarsx.cherrygram"
busybox tar xf uz.unnarsx.cherrygram.tar

# Определяем ID пользователя приложения Challegram
ID=$(su - root -c "ls -l /data/data/ | grep cherr | head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "rm /data/data/org.thunderdog.challegram/files/tdlib/td.binlog"
su - root -c "cp -R  uz.unnarsx.cherrygram  /data/data/"
su - root -c "chown -R  $ID:$ID /data/data/uz.unnarsx.cherrygram"
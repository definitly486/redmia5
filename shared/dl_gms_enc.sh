#!/system/bin/sh

# Проверяем наличие введенного пароля
if [ -z "$1" ]; then
    echo "не введен пароль для распаковки authenticator"
    exit 1
fi

PASSWORD="$1" # сохраняем пароль в отдельной переменной

# Скачиваем зашифрованный архив, если его ещё нет
if ! [ -f "com.google.android.gms.tar.enc" ]; then
    curl -k -L -o com.google.android.gms.tar.enc \
       https://github.com/definitly486/redmia5/releases/download/shared/com.google.android.gms.tar.enc
fi

# Используем экранирование пароля с помощью printf
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -d \
    -in com.google.android.gms.tar.enc  \
    -out com.google.android.gms.tar \
    -pass pass:$PASSWORD

# Извлекаем содержимое архива
su - root -c "rm -R com.google.android.gms"
busybox tar xf com.google.android.gms.tar

# Определяем ID пользователя приложения com.qflair.browserq
ID=$(su - root -c "ls -l /data/data/ | grep "com.google.android.gms" | head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "cp -R  com.google.android.gms   /data/data/"
su - root -c "chown -R  $ID:$ID /data/data/com.google.android.gms"
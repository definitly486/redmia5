#!/system/bin/sh

# Проверяем наличие введенного пароля
if [ -z "$1" ]; then
    echo "не введен пароль для распаковки authenticator"
    exit 1
fi

PASSWORD="$1" # сохраняем пароль в отдельной переменной

# Скачиваем зашифрованный архив, если его ещё нет
if ! [ -f "com.google.android.apps.authenticator2.tar.enc" ]; then
    curl -k -L -o com.google.android.apps.authenticator2.tar.enc \
       https://github.com/definitly486/redmia5/releases/download/shared/com.google.android.apps.authenticator2.tar.enc
fi

# Используем экранирование пароля с помощью printf
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -d \
    -in com.google.android.apps.authenticator2.tar.enc  \
    -out com.google.android.apps.authenticator2.tar \
    -pass pass:$PASSWORD

# Извлекаем содержимое архива
su - root -c "rm -R com.google.android.apps.authenticator2"
busybox tar xf com.google.android.apps.authenticator2.tar

# Определяем ID пользователя приложения com.qflair.browserq
ID=$(su - root -c "ls -l /data/data/ | grep authenticator2 | head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "cp -R com.google.android.apps.authenticator2/files/accounts    /data/data/com.google.android.apps.authenticator2/files/"
su - root -c "chown -R  $ID:$ID /data/data/com.google.android.apps.authenticator2/com.google.android.apps.authenticator2/files/accounts"
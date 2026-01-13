#!/system/bin/sh

# Проверяем наличие введенного пароля
if [ -z "$1" ]; then
    echo "не введен пароль для распаковки mynalog"
    exit 1
fi

PASSWORD="$1" # сохраняем пароль в отдельной переменной

# Скачиваем зашифрованный архив, если его ещё нет
if ! [ -f "com.gnivts.selfemployed.tar.enc" ]; then
    curl -k -L -o com.gnivts.selfemployed.tar.enc \
       https://github.com/definitly486/redmia5/releases/download/shared/com.gnivts.selfemployed.tar.enc
fi

# Используем экранирование пароля с помощью printf
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -d \
    -in com.gnivts.selfemployed.tar.enc  \
    -out com.gnivts.selfemployed.tar \
    -pass pass:$PASSWORD

# Извлекаем содержимое архива
su - root -c "rm -R com.gnivts.selfemployed"
busybox tar xf com.gnivts.selfemployed.tar

# Определяем ID пользователя приложения com.gnivts.selfemployed
ID=$(su - root -c "ls -l /data/data/ | grep "com.gnivts.selfemployed" | head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "cp -R  com.gnivts.selfemployed   /data/data/"
su - root -c "chown -R  $ID:$ID /data/data/com.gnivts.selfemployed"
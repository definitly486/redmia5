#!/system/bin/sh
# Скачиваем  архив, если его ещё нет
if ! [ -f "com.teslacoilsw.launcher.tar" ]; then
    curl -k -L -o com.teslacoilsw.launcher.tar \
       https://github.com/definitly486/redmia5/releases/download/shared/com.teslacoilsw.launcher.tar
fi



# Извлекаем содержимое архива
su - root -c "rm -R  com.teslacoilsw.launcher"
busybox tar xf com.teslacoilsw.launcher.tar
# Определяем ID пользователя приложения com.fsck.k9
ID=$(su - root -c "ls -l /data/data/ | grep teslacoilsw | head -n 1 | awk '{print \$3}'")

# Удаляем старый файл журнала TDLib и копируем новый
su - root -c "cp -R  com.teslacoilsw.launcher  /data/data/"
su - root -c "chown -R  $ID:$ID /data/data/com.teslacoilsw.launcher"
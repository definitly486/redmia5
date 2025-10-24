#!/system/bin/sh
if [ -z "$1" ]
then
     echo "не введен пароль для распаковки pluma "
     exit
fi
DIR=$(dirname "$(realpath $0)")

unpack () {
    if ! [ -f "com.qflair.browserq.tar.xz.enc" ]; then
        curl -k -L -o com.qflair.browserq.tar.xz.enc https://github.com/definitly486/Lenovo_Tab_3_7_TB3-730X/releases/download/shared/com.qflair.browserq.tar.xz.enc || {
            echo "Ошибка загрузки файла!"
            return 1
        }
    fi

    openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -e -d -in com.qflair.browserq.tar.xz.enc -out com.qflair.browserq.tar.xz -pass pass:"$1" || {
        echo "Ошибка расшифровки файла!"
        return 1
    }

    busybox tar xf com.qflair.browserq.tar.xz || {
        echo "Ошибка распаковки архива!"
        return 1
    }

    su - root -c "mkdir -p /data/data/com.qflair.browserq" || {
        echo "Ошибка создания директории!"
        return 1
    }

    su - root -c "cp -r $DIR/com.qflair.browserq/databases /data/data/com.qflair.browserq" || {
        echo "Ошибка копирования базы данных!"
        return 1
    }

    su - root -c "chmod -R 700 /data/data/com.qflair.browserq/databases" || {
        echo "Ошибка изменения прав доступа!"
        return 1
    }

    su - root -c "cp -r $DIR/com.qflair.browserq/shared_prefs /data/data/com.qflair.browserq" || {
        echo "Ошибка копирования shared_prefs!"
        return 1
    }

    su - root -c "chmod -R 700 /data/data/com.qflair.browserq/shared_prefs" || {
        echo "Ошибка изменения прав доступа!"
        return 1
    }
}

unpack "$1"
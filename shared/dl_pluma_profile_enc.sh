#!/system/bin/sh
if [ -z "$1" ]
then
     echo "не введен пароль для распаковки pluma "
     exit
fi
DIR=$(dirname "$(realpath $0)")



unpack () {

if ! [  -f "com.qflair.browserq.tar.xz.enc" ]; then
     curl -k  -L -o    com.qflair.browserq.tar.xz.enc    https://github.com/definitly486/Lenovo_Tab_3_7_TB3-730X/releases/download/shared/com.qflair.browserq.tar.xz.enc 
fi
openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -e -d  -in   com.qflair.browserq.tar.xz.enc -out  com.qflair.browserq.tar.xz     -pass pass:$1   
busybox tar xf com.qflair.browserq.tar.xz
su - root -c "mkdir -p /data/data/com.qflair.browserq"
su - root -c "cp -r  $DIR/com.qflair.browserq/databases   /data/data/com.qflair.browserq"
su - root -c "chmod -R  700  /data/data/com.qflair.browserq/databases"
su - root -c "cp -r  $DIR/com.qflair.browserq/shared_prefs   /data/data/com.qflair.browserq"
su - root -c "chmod -R  700  /data/data/com.qflair.browserq/shared_prefs"
}

 unpack 


#!/system/bin/sh
if [ -z "$1" ]
then
     echo "не введен пароль для распаковки telegram "
     exit
fi

if ! [  -f "td.binlog.tar.xz.enc" ]; then
     curl -k -L -o   td.binlog.tar.xz.enc    https://github.com/definitly486/Lenovo_Tab_3_7_TB3-730X/releases/download/shared/td.binlog.tar.xz.enc 
fi

openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -e -d  -in  td.binlog.tar.xz.enc  -out  td.binlog.tar.xz     -pass pass:$1   
busybox tar xf td.binlog.tar.xz 
ID=$(su - root -c "ls  -l /data/data/ | grep chall | head -n 1 | sed 's/[^ ]* //' |  cut -d' ' -f1")
ID2=$(echo $ID | tr -d '\r')
su - root -c "chown $ID2:$ID2 td.binlog"
su - root -c "rm  /data/data/org.thunderdog.challegram/files/tdlib/td.binlog"
su - $ID2  -c "cp  td.binlog /data/data/org.thunderdog.challegram/files/tdlib"



#!/system/bin/sh
DIR=$(dirname "$(realpath $0)")
if ! [  -f "com.qflair.browserq.tar.xz" ]; then
     curl -k -L -o   com.qflair.browserq.tar.xz   https://github.com/definitly486/Lenovo_Tab_3_7_TB3-730X/releases/download/shared/com.qflair.browserq.tar.xz
fi
busybox tar xf com.qflair.browserq.tar.xz
su - root -c "mkdir -p /data/data/com.qflair.browserq"
su - root -c "cp -r  $DIR/com.qflair.browserq/databases   /data/data/com.qflair.browserq"
su - root -c "chmod -R  700  /data/data/com.qflair.browserq/databases"
su - root -c "cp -r  $DIR/com.qflair.browserq/shared_prefs   /data/data/com.qflair.browserq"
su - root -c "chmod -R  700  /data/data/com.qflair.browserq/shared_prefs"
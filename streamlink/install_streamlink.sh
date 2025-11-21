#!/system/bin/sh

if ! [  -f "streamlink.tar.gz" ]; then
    curl -L -k  -o   streamlink.tar.gz  https://github.com/definitly486/redmia5/releases/download/streamlink/streamlink.tar.gz
fi

busybox tar xf streamlink.tar.gz
su - root -c "cp data/usr/bin/streamlink /system/bin"
su - root -c "cp -R data/usr/lib/python3 /system/lib64"
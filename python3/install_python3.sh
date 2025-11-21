#!/system/bin/sh

if ! [  -f "python-3.13-android-aarch64.tar.gz" ]; then
    curl -L -k  -o   python-3.13-android-aarch64.tar.gz  https://github.com/definitly486/redmia5/releases/download/python3/python-3.13-android-aarch64.tar.gz
fi

su - root -c "busybox tar xf python-3.13-android-aarch64.tar.gz  -C /data/local/tmp"
su - root -c "chmod -R 0755 /data/local/tmp/python-android-aarch64"
su - root -c "chmod +x /data/local/tmp/python-android-aarch64/bin/python3.13"
su - root -c "chmod -R 0755 /data/local/tmp/python-android-aarch64/bin"
su - root -c "chmod  0755 /data/local/tmp/python-android-aarch64/bin/python3.13"
su - root -c "cp python3 /system/bin"
su - root -c "chmod -R 0755 /system/bin/python3"

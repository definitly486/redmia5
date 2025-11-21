#!/system/bin/sh

if ! [  -f "python-3.13-android-aarch64.tar.gz" ]; then
    curl -L -k  -o   python-3.13-android-aarch64.tar.gz  https://github.com/definitly486/redmia5/releases/download/python3/python-3.13-android-aarch64.tar.gz
fi

busybox tar xf python-3.13-android-aarch64.tar.gz  -C /data/local/tmp

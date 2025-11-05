#!/system/bin/sh


if ! [  -f "git-core.tar" ]; then
    curl -L -k  -o   git-core.tar  https://github.com/definitly486/redmia5/releases/download/git/git-core.tar
fi

busybox tar xf  git-core.tar
mkdir -p /data/data/com.termux/files/usr/share
cp -r git-core   /data/data/com.termux/files/usr/share
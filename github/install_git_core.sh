#!/system/bin/sh


if ! [  -f "git-core.tar" ]; then
    curl -L -k  -o   git-core.tar  https://github.com/definitly486/redmia5/releases/download/git/git-core.tar
fi

busybox tar xf  git-core.tar
su - root -c "mkdir -p /data/data/com.termux/files/usr/share"
su - root -c "cp -r git-core   /data/data/com.termux/files/usr/share"

ID=$(su - root -c "ls -l /data/data/ | grep termos | head -n 1 | awk '{print \$3}'")
su - root -c "chown -R  $ID:$ID /data/data/com.termux"
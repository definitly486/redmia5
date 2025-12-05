#!/system/bin/sh

if ! [  -f "htop" ]; then
    curl -L -k  -o   htop  https://github.com/definitly486/redmia5/releases/download/htop/htop
fi

su - root -c "mount -o rw,remount /system"
su - root -c "cp htop /system/bin"
su - root -c "chmod -R 0755 /system/bin/htop"
su - root -c "chmod +x /system/bin/htop"
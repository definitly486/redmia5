#!/bin/sh

BOOT=android13-5.15.167_2024-11-boot.img

mkdir /tmp/redmia5

if [ !  -f "/tmp/redmia5/$BOOT" ]; then
    echo "Файл $BOOT   не существует"
    echo "Скачиваем $BOOT"
    fetch --no-verify-peer  https://github.com/definitly486/redmia5/releases/download/root/$BOOT  -o /tmp/redmia5/$BOOT
fi

fastboot flash boot_a /tmp/redmia5/$BOOT
fastboot flash boot_b /tmp/redmia5/$BOOT
fastboot reboot
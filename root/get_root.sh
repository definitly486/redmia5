#!/bin/sh

mkdir /tmp/redmia5

if [ !  -f "/tmp/redmia5/boot_path.img" ]; then
    echo "Файл boot_path.img   не существует"
    echo "Скачиваем boot_path.img"
    fetch --no-verify-peer  https://github.com/definitly486/redmia5/releases/download/root/boot_path.img -o /tmp/redmia5/boot_path.img
fi

fastboot flash boot_a /tmp/redmia5/boot_path.img
fastboot flash boot_b /tmp/redmia5/boot_path.img
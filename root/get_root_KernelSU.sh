#!/bin/sh
#этот img для serenity_eea_global_images_A15.0.5.0.VGWEUXM_15.0

BOOT=kernelsu_patched_20251023_111041.img

mkdir /tmp/redmia5

if [ !  -f "/tmp/redmia5/$BOOT" ]; then
    echo "Файл $BOOT   не существует"
    echo "Скачиваем $BOOT"
    fetch --no-verify-peer  https://github.com/definitly486/redmia5/releases/download/root/$BOOT  -o /tmp/redmia5/$BOOT
fi

/usr/local/bin/fastboot flash boot_a /tmp/redmia5/$BOOT
/usr/local/bin/fastboot flash boot_b /tmp/redmia5/$BOOT
/usr/local/bin/fastboot reboot
#!/bin/sh
killall -9 adb
dir=$(dirname "$(realpath $0)")
adb shell su - root -c "mount -o rw,remount /"
  for i in $(cat $dir/pkg_path ); do

    adb shell        su - root -c  "rm -r    $i" 

done

adb shell su - root -c 'mount -o ro,remount /'
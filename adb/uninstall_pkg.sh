#!/bin/sh
killall -9 adb
adb kill-server
dir=$(dirname "$(realpath $0)")

  for i in $(cat $dir/unistall_pkg ); do

            adb shell pm uninstall --user 0   $i 

done
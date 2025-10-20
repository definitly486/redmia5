#!/bin/sh
dir=$(dirname "$(realpath $0)")

  for i in $(cat $dir/unistall_pkg ); do

            adb shell pm list packages -f    $i | gsed  's/package://'  | gsed  's/package://' |  rev | sed -r 's!^[^/]+!!' | rev >> pkg_path

done
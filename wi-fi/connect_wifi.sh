adb kill-server
ip=$(adb shell "ip addr show wlan0 2>/dev/null" | awk '/inet /{print $2}' | cut -d/ -f1)
echo $ip
adb tcpip 5555
adb connect $ip:5555
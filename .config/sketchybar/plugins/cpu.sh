#!/usr/bin/env sh

BLACK=0xff181926
WHITE=0xffcad3f5
RED=0xffed8796
GREEN=0xffa6da95
BLUE=0xff8aadf4
YELLOW=0xffeed49f
ORANGE=0xfff5a97f
MAGENTA=0xffc6a0f6
GREY=0xff939ab7
TRANSPARENT=0x00000000

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,user)
CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

TOPPROC=$(ps axo "%cpu,ucomm" | sort -nr | tail +1 | head -n1 | awk '{printf "%.0f%% %s\n", $1, $2}' | sed -e 's/com.apple.//g')
CPUP=$(echo $TOPPROC | sed -nr 's/([^\%]+).*/\1/p')

CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

COLOR=$WHITE
case "$CPU_PERCENT" in
  [1-2][0-9]) COLOR=$YELLOW
  ;;
  [3-6][0-9]) COLOR=$ORANGE
  ;;
  [7-9][0-9]|100) COLOR=$RED
  ;;
esac

sketchybar --set  cpu.percent label=$CPU_PERCENT% \
                              label.color=$COLOR  \
           --set  cpu.top     label="$TOPPROC"    \
           --push cpu.sys     $CPU_SYS            \
           --push cpu.user    $CPU_USER

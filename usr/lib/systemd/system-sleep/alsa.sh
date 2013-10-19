#!/bin/sh
#
# alsa.sh: systemd suspend/wakeup ALSA devices

case "$1" in
pre)
;;
post)
aplay -d 1 /dev/zero
;;
esac

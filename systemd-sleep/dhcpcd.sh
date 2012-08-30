#!/bin/sh
#
# dhcpcd.sh: systemd suspend/wakeup dhcpcd@.service

case "$1" in
	pre)
		systemctl stop dhcpcd@web.service
	;;
	post)
		systemctl start dhcpcd@web.service
	;;
esac

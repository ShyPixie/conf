#!/bin/sh
#
# network.sh: systemd suspend/wakeup network.service

case "$1" in
	pre)
		systemctl stop network.service
	;;
	post)
		systemctl start network.service
	;;
esac

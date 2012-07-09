#!/bin/sh
if [ `id -u` == 0 ]; then echo "EPA!"; fi
function _cp() {
	if [ -f "$1" ]; then
		echo "Copiando arquivo '$1' para '$2'"
		cp -f "$1" "$2" || exit 1
	fi
}

_cp "${HOME}/.Xresources"                  "Xresources"
_cp "${HOME}/.xinitrc"                     "xinitrc"
_cp "${HOME}/.asoundrc"                    "asoundrc"
_cp "${HOME}/.pypanelrc"                   "pypanelrc"
#_cp "${HOME}/.config/geany/geany.conf"     "geany.conf"
_cp "${HOME}/.config/openbox/autostart.sh" "openbox/autostart.sh"
_cp "${HOME}/.config/openbox/menu.xml"     "openbox/menu.xml"
_cp "${HOME}/.config/openbox/rc.xml"       "openbox/rc.xml"
_cp "/etc/modprobe.d/k10temp.conf"         "modprobe.d/k10temp.conf"
_cp "/etc/modprobe.d/r8169_blacklist.conf" "modprobe.d/r8169_blacklist.conf"
_cp "/etc/iptables/iptables.rules"         "iptables.rules"
_cp "/etc/X11/xorg.conf"                   "xorg.conf"
_cp "/etc/bash.bashrc"                     "etc/bash.bashrc"
_cp "/etc/gamemanager.conf"                "etc/gamemanager.conf"
_cp "/etc/dhcpcd.conf"                     "etc/dhcpcd.conf"
_cp "/etc/fstab"                           "etc/fstab"
_cp "/etc/inittab"                         "etc/inittab"
_cp "/etc/lilo.conf"                       "etc/lilo.conf"
_cp "/etc/makepkg.conf"                    "etc/makepkg.conf"
_cp "/etc/mkinitcpio.conf"                 "etc/mkinitcpio.conf"
_cp "/etc/resolv.conf.head"                "etc/resolv.conf.head"
_cp "/etc/resolv.conf.tail"                "etc/resolv.conf.tail"
_cp "/etc/sysctl.conf"                     "etc/sysctl.conf"
_cp "/etc/systemd/system/network.service"  "systemd-units/network.service"
_cp "/etc/systemd/system/noip.service"     "systemd-units/noip.service"
_cp "/etc/systemd/system/pacmandb.service" "systemd-units/pacmandb.service"
#lighttpd
#squid
#sudoers

echo "Tarefa completada com sucesso!"
exit 0

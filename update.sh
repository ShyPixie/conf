#!/bin/sh
test $(id -u) == 0 && echo "EPA" && exit 1

function _cp() {
	if [ -f "$1" ]; then
		echo "Copiando arquivo '$1' para '$2'"
		cp -f "$1" "$2" || exit 1
	fi
}

# HOME
_cp "${HOME}/.Xresources"                  "Xresources"
_cp "${HOME}/.xinitrc"                     "xinitrc"
_cp "${HOME}/.conkyrc"                     "conkyrc"
_cp "${HOME}/.pypanelrc"                   "pypanelrc"
#_cp "${HOME}/.config/geany/geany.conf"     "geany.conf"
_cp "${HOME}/.config/pacaur/config"        "pacaur_config"

# Openbox
_cp "${HOME}/.config/adeskbar/viny.cfg"    "adeskbar.cfg"
_cp "${HOME}/.config/openbox/autostart.sh" "openbox/autostart.sh"
_cp "${HOME}/.config/openbox/menu.xml"     "openbox/menu.xml"
_cp "${HOME}/.config/openbox/rc.xml"       "openbox/rc.xml"

# kde
_cp "${HOME}/.kde4/env/firefox-pango.sh"     "kde/env/firefox-pango.sh"
_cp "${HOME}/.kde4/env/gpu-overclock.sh"     "kde/env/gpu-overclock.sh"
_cp "${HOME}/.kde4/env/gtk2-env.sh"          "kde/env/gtk2-env.sh"
_cp "${HOME}/.kde4/env/opengl-vsync.sh"      "kde/env/opengl-vsync.sh"
_cp "${HOME}/.kde4/env/qt-graphicssystem.sh" "kde/env/qt-graphicssystem.sh"
_cp "${HOME}/.kde4/share/config/kwinrc"      "kde/kwinrc"
_cp "/usr/share/config/kdm/Xsession"         "kde/Xsession"
#_cp "/usr/share/apps/kdm/sessions/kde-plasma.desktop" "kde/kde-plasma.desktop"

# modprobe.d
_cp "/etc/modprobe.d/k10temp.conf"           "modprobe.d/k10temp.conf"
_cp "/etc/modprobe.d/alsa.conf"              "modprobe.d/alsa.conf"
_cp "/etc/modprobe.d/r8169_blacklist.conf"   "modprobe.d/r8169_blacklist.conf"
_cp "/etc/modprobe.d/nouveau_blacklist.conf" "modprobe.d/nouveau_blacklist.conf"

# initcpio hooks
_cp "/usr/lib/initcpio/install/nvidia"    "initcpio-hooks/nvidia"
_cp "/usr/lib/initcpio/install/r8168"     "initcpio-hooks/r8168"

# /etc
_cp "/etc/iptables/iptables.rules"         "iptables.rules"
_cp "/etc/X11/xorg.conf"                   "xorg.conf"
_cp "/etc/bash.bashrc"                     "etc/bash.bashrc"
_cp "/etc/gamemanager.conf"                "etc/gamemanager.conf"
_cp "/etc/dhcpcd.conf"                     "etc/dhcpcd.conf"
#_cp "/etc/fstab"                           "etc/fstab"
#_cp "/etc/inittab"                         "etc/inittab"
_cp "/etc/lilo.conf"                       "etc/lilo.conf"
_cp "/etc/makepkg.conf"                    "etc/makepkg.conf"
_cp "/etc/yaourtrc"                        "etc/yaourtrc"
_cp "/etc/pacman.conf"                     "etc/pacman.conf"
_cp "/etc/hostname"                        "etc/hostname"
_cp "/etc/vconsole.conf"                   "etc/vconsole.conf"
_cp "/etc/locale.conf"                     "etc/locale.conf"
_cp "/etc/localtime"                       "etc/localtime"
_cp "/etc/mkinitcpio.conf"                 "etc/mkinitcpio.conf"
_cp "/etc/resolv.conf"                     "etc/resolv.conf"
_cp "/etc/sysctl.conf"                     "etc/sysctl.conf"
_cp "/etc/asound.conf"                     "etc/asound.conf"
# /srv/lighttpd
# /srv/squid
# /etc/sudoers
# ~/.Skype/config.xml

# udev
_cp "/etc/udev/rules.d/10-network.rules"   "etc/udev/rules.d/10-network.rules"

# systemd-units
_cp "/etc/systemd/system/network.service"     "systemd-units/network.service"
_cp "/etc/systemd/system/dhcpcd@.service"     "systemd-units/dhcpcd@.service"
_cp "/etc/systemd/system/noip.service"        "systemd-units/noip.service"
_cp "/etc/systemd/system/leds.service"        "systemd-units/leds.service"
_cp "/etc/systemd/system/xinit-login.service" "systemd-units/xinit-login.service"
_cp "/etc/systemd/system/pacmandb.service"    "systemd-units/pacmandb.service"

# systemd-mounts
_cp "/etc/systemd/system/dev-sda2.swap"     "systemd-mounts/dev-sda2.swap"
_cp "/etc/systemd/system/boot.mount"        "systemd-mounts/boot.mount"
_cp "/etc/systemd/system/boot.automount"    "systemd-mounts/boot.automount"
_cp "/etc/systemd/system/system.mount"      "systemd-mounts/system.mount"
_cp "/etc/systemd/system/home.mount"        "systemd-mounts/home.mount"

# systemd-sleep
_cp "/usr/lib/systemd/system-sleep/alsa.sh"    "systemd-sleep/alsa.sh"
_cp "/usr/lib/systemd/system-sleep/network.sh" "systemd-sleep/network.sh"
_cp "/usr/lib/systemd/system-sleep/dhcpcd.sh"  "systemd-sleep/dhcpcd.sh"

# boot
_cp "/boot/syslinux/syslinux.cfg"       "syslinux.cfg"

echo "Tarefa completada com sucesso!"
exit 0

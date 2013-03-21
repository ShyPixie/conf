[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
export GTK2_RC_FILES="/etc/gtk-2.0/gtkrc:$HOME/.gtkrc-2.0"
setxkbmap -model abnt2 br -option compose:rwin

nvidia-settings -a GPUOverclockingState=1
nvidia-settings -a GPU3DClockFreqs=631,912
export __GL_SYNC_TO_VBLANK=0

export MOZ_DISABLE_PANGO=1

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd \
                      -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export JAVA_FONTS=/usr/share/fonts/TTF

source /etc/profile

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for arquivo in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$arquivo" ] && . "$arquivo"
	done
fi

echo enabled > /sys/class/net/web/device/power/wakeup

default=enlightenment_start

case $1 in
	openbox) openbox-session ;;
	mate)    mate-session    ;;
	kde)     if [ -f /usr/bin/faststartkde ]; then faststartkde; else startkde; fi ;;
	razor)   razor-session   ;;
	xfce)    xfce4-session   ;;
	gnome)   gnome-shell     ;;
	cinnamon)   gnome-session-cinnamon   ;;
	cinnamon2d) gnome-session-cinnamon2d ;;
	enlightenment) enlightenment_start ;;
	*) exec "$default" "$@"  ;;
esac

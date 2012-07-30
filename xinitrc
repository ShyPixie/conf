[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
export GTK2_RC_FILES="/etc/gtk-2.0/gtkrc:$HOME/.gtkrc-2.0"
setxkbmap -model abnt2 br -option compose:rwin

nvidia-settings -a GPUOverclockingState=1
nvidia-settings -a GPU3DClockFreqs=631,912
export __GL_SYNC_TO_VBLANK=0

source /etc/profile

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for arquivo in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$arquivo" ] && . "$arquivo"
	done
fi

openbox-session

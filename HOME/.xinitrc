# Fix pcmanfm "Open with" dialog with openbox (need install lxmenu-data)
export XDG_MENU_PREFIX=lxde-
export XDG_CURRENT_DESKTOP=LXDE

# Fix Gtk look
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Load xorg extras from /etc/X11/xinit/xinitrc.d
if test -d /etc/X11/xinit/xinitrc.d/; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        test -r "$f" && . "$f"
    done
    unset f
fi

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
    for profile in /etc/profile.d/*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi

start-pulseaudio-x11 --start

openbox-session

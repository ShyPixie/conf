# Lara Maia <lara@craft.net.br> © 2015

# Carregar módulos do gtk
if test -z $GTK_MODULES
then
    GTK_MODULES="canberra-gtk-module"
else
    GTK_MODULES="$GTK_MODULES:canberra-gtk-module"
fi
export GTK_MODULES

# Carregar configurações do xinit
if test -d /etc/X11/xinit/xinitrc.d/
then
    for conf in /etc/X11/xinit/xinitrc.d/*.sh; do
        test -x "$conf" && . "$conf"
    done
    unset conf
fi

# Carregar configuração do profile
if test -d /etc/profile.d/
then
    for profile in /etc/profile.d/*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi

# Iniciar sessão
#/usr/bin/openbox
#/usr/bin/lboxwm
#/usr/bin/rox -S
#/usr/bin/gnome-session
#/usr/bin/xfce4-session
/usr/bin/cinnamon-session
#/usr/bin/budgie-session

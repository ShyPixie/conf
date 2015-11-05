# Lara Maia <lara@craft.net.br> © 2015

# Carregar configurações do xinit
if test -d /etc/X11/xinit/xinitrc.d/
then
    for conf in /etc/X11/xinit/xinitrc.d/*; do
        test -x "$conf" && . "$conf"
    done
    unset conf
fi

# Carregar configuração do profile
. /etc/profile

# Iniciar sessão
#/usr/bin/openbox
#/usr/bin/lboxwm
#/usr/bin/rox -S
#/usr/bin/gnome-session
#/usr/bin/xfce4-session
/usr/bin/cinnamon-session
#/usr/bin/budgie-session

# Lara Maia <dev@lara.click> 2016

# https://bugs.freedesktop.org/show_bug.cgi?id=49950
setxkbmap -layout br -variant abnt2

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
/usr/bin/startxfce4
#/usr/bin/cinnamon-session

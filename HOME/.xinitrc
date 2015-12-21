# Lara Maia <dev@lara.click> 2016

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
/usr/bin/cinnamon-session

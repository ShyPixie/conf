# Lara Maia <lara@craft.net.br> © 2013

xrdb -merge "$HOME/.Xresources"

# Carregar módulos do gtk
  if [[ -z $GTK_MODULES ]]; then
    GTK_MODULES="canberra-gtk-module"
  else
    GTK_MODULES="$GTK_MODULES:canberra-gtk-module"
  fi
export GTK_MODULES

# Não carregar a droga da sessão salva
rm ~/.cache/sessions/xfce4-session-Amora\:0

# Iniciar sessão
xfce4-session

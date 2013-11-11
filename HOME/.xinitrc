# Lara Maia <lara@craft.net.br> © 2013

#  O xdm já faz o merge...
# xrdb -merge "$HOME/.Xresources" 

# Definir corretamente as variáveis do dbus (address, pid)
eval $(dbus-launch --sh-syntax --exit-with-session)

# Carregar módulos do gtk
  if [[ -z $GTK_MODULES ]]; then
	GTK_MODULES="canberra-gtk-module"
  else
	GTK_MODULES="$GTK_MODULES:canberra-gtk-module"
  fi
export GTK_MODULES

# Carregar configurações da nvidia
nvidia-settings --load-config-only

# Iniciar sessão
openbox-session

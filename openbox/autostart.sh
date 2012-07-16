# Desabilitar output
exec >/dev/null 2>&1

#--- papel de parede ---
#nitrogen --restore
hsetroot -fill ~/Imagens/papel_de_parede.png &
tilda &

#--- Compositores ---
~/.compstart

#--- Daemons de notificação ---
notipy &
#xfce4-notifyd &
#notification-daemon &

#--- Paineis ---
#tint2 &
#bmpanel2 &
pypanel &
#xfce4-panel &
(sleep 3 && conky) &

#--- Docks ---
#cairo-dock &
#dockx &
#avant-window-navigator &

#--- Mensageiros ---
#emesene2 &
#amsn &
#amsn2 &
#kmess &
#skype &
#pidgin &

#--- Controle de volume
volwheel &
#volti &
#pyvol &

#--- Gerenciadores de clipboard ---
(sleep 3 && pasteall) &

#--- Torrent ---
# deluge &
deluged &

#--- IRC ---
#qirssi &

exit 0

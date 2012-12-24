# Desabilitar output
exec >/dev/null 2>&1

#--- papel de parede ---
#nitrogen --restore
if [ -f ~/Imagens/papel_de_parede.jpg ]; then
	hsetroot -fill ~/Imagens/papel-de-parede.jpg &
else
	hsetroot -fill ~/Imagens/papel-de-parede.png &
fi
#tilda &

#--- Compositores ---
~/.compstart

#--- Daemons de notificação ---
notipy &
#xfce4-notifyd &
#notification-daemon &

#--- Paineis ---
#tint2 &
bmpanel2 &
#pypanel &
#xfce4-panel &
#adeskbar viny &
(sleep 2 && conky) &

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
#volwheel &
#volti &
#pyvol &

#--- Gerenciadores de clipboard ---
(sleep 3 && pasteall) &

#--- Torrent ---
# deluge &
#deluged &

#--- IRC ---
#qirssi &

#--- NumLock Maldito ---
numlockx on

#--- ... ---
#(sleep 3
#oneko -neko -bg pink -speed 10 -idle 200 -name neko &
#sleep 1
#oneko -tomoyo -toname neko -name tomoyo -speed 5 &
#sleep 1
#oneko -dog -bg brown -toname neko -speed 7 &
#sleep 1
#xsetroot -cursor_name left_ptr) &

exit 0

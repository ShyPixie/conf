#--- Compositores ---
compton -CcfF -I-.015 -O-.03 -D6 -t-1 -l-3 -r4.2 -o.5 2>/dev/null &
#compmgr -CcfF -I-.015 -O-.03 -D6 -t-1 -l-3 -r4.2 -o.5 2>/dev/null &

#--- Daemons de notificação ---
notipy.py -m 20,30,80,20 -a SOUTH_EAST &
#xfce4-notifyd &
#notification-daemon &

#--- Paineis ---
#tint2 &
bmpanel2 &
#pypanel &
#xfce4-panel &

#--- Docks ---
#cairo-dock &
#dockx &
#avant-window-navigator &

#--- Clientes de Msn ---
#emesene2 &
#amsn &
#amsn2 &
#kmess &

#--- Controle de volume
volwheel &
#volti &
#pyvol &

#--- Gerenciadores de clipboard ---
pasteall &

#--- Torrent ---
# deluge &
deluged &

#--- IRC ---
#qirssi &

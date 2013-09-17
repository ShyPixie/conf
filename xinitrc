[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
setxkbmap -model abnt2 br -option compose:rwin

source /etc/profile

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for arquivo in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$arquivo" ] && . "$arquivo"
	done
fi

while true; do
	xfce4-session
	killall -9 gigolo
	killall -9 geany
	killall -9 guake
	killall -9 firefox
	sleep .5
	xfwm4 &
	return=$(yad --form --title="O que deseja?" \
		            --width=200 \
		            --height=50 \
		            --field="Opção:":CB Desligar!Reiniciar!"Nova sessão")

	case $return in
		"Desligar|") sudo systemctl poweroff ;;
		"Reiniciar|") sudo systemctl reboot ;;
		"Nova sessão|") continue ;;
		*) yad --title "ERRO!" --text "Opção Inválida." --button=Ok:0 ;;
	esac
done

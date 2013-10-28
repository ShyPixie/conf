#!/bin/sh
# Lara Maia © 2012 ~ 2013 <lara@craft.net.br>
# version: 3.1

test $(id -u) == 0 && echo "EPA" && exit 1

function checkfiles() {
	# Accept single update
	test "$1" != "" && FILES=("$1")
	
	for file in ${FILES[@]}; do
		
		# if is $home
		if [ ${file:0:${#HOME}} == "$HOME" ]; then
			dest=HOME${file:${#HOME}}
		elif [ ${file:0:1} == "/" ]; then
			dest=${file:1}
		fi
		
		if [ -f "$file" ]; then
		
			# Prevent destination not found
			test ! -f "$dest" && mkdir -p ${dest%/*} && touch $dest
			
			if ! colordiff -u "$dest" "$file"; then
				while true; do
					echo -ne "==> [C]opiar, [R]estaurar, [I]gnorar, [S]air: "
					read -n 1 opc
					
					case $opc in
						C|c) echo "==> Fazendo backup de '$file'"
						     cp -f "$file" "$dest" && echo -e "\n" && break || exit 1 ;;
						R|r) sudo cp -f "$dest" "$file" && echo -e "\n" && break || exit 1 ;;
						I|i) test -f $dest && rm $dest; echo -e "\n" && break ;;
						S|s|E|e) exit 1 ;;
						*) echo -ne " < Opção incorreta\r\n" && continue ;;
					esac
				done
			fi
		else
			echo -e "\n * O arquivo $file não existe no sistema de arquivos, ignorando."
		fi
	done
}

echo -n "Criando lista de arquivos arquivos... "

declare -x FILES=(

# HOME
${HOME}/.Xresources
${HOME}/.xinitrc
${HOME}/.conkyrc
${HOME}/.pypanelrc
${HOME}/.config/geany/geany.conf
${HOME}/.config/pacaur/config
${HOME}/.config/alsi/alsi.logo
${HOME}/.config/alsi/alsi.output
${HOME}/.config/alsi/alsi.conf
${HOME}/.config/fish/config.fish

# Fluxbox
${HOME}/.fluxbox/startup
${HOME}/.fluxbox/keys
${HOME}/.fluxbox/overlay

# Openbox
${HOME}/.config/openbox/autostart.sh
${HOME}/.config/openbox/menu.xml
${HOME}/.config/openbox/rc.xml

# modprobe.d
/etc/modprobe.d/k10temp.conf
/etc/modprobe.d/alsa.conf
/etc/modprobe.d/r8169_blacklist.conf
/etc/modprobe.d/nouveau_blacklist.conf

# initcpio hooks
/usr/lib/initcpio/install/nvidia
/usr/lib/initcpio/install/r8168

# /etc
/etc/iptables/iptables.rules
/etc/X11/xorg.conf          
/etc/bash.bashrc   
/etc/dhcpcd.conf          
/etc/makepkg.conf           
/etc/yaourtrc               
/etc/pacman.conf            
/etc/hostname               
/etc/vconsole.conf          
/etc/locale.conf            
/etc/localtime              
/etc/mkinitcpio.conf        
/etc/resolvconf.conf            
/etc/sysctl.d/99-sysctl.conf
/etc/asound.conf
# /srv/squid
# /etc/sudoers

# udev
/etc/udev/rules.d/10-network.rules

# systemd-units
/etc/systemd/system/noip.service       
/etc/systemd/system/leds.service       
/etc/systemd/system/xinit-login.service

# systemd-mounts
/etc/systemd/system/dev-sda2.swap 
/etc/systemd/system/boot.mount    
/etc/systemd/system/boot.automount
/etc/systemd/system/system.mount  
/etc/systemd/system/home.mount    

# systemd-sleep
/usr/lib/systemd/system-sleep/alsa.sh   
/usr/lib/systemd/system-sleep/network.sh
/usr/lib/systemd/system-sleep/dhcpcd.sh 

# boot
/boot/syslinux/syslinux.cfg

); echo -e "Concluído.\n"

echo -n "Verificando arquivos... "; checkfiles "$1"; echo -e "Concluído.\n"

echo "Tarefa completada com sucesso!"
exit 0

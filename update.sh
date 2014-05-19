#!/bin/sh
# Lara Maia © 2012 ~ 2013 <lara@craft.net.br>
# version: 3.1.3

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
                        C|c) echo -e "\n==> Fazendo backup de '$file'"
                             cp -f "$file" "$dest" && echo -e "\n" && break || exit 1 ;;
                        R|r) echo && sudo cp -f "$dest" "$file" && echo -e "\n" && break || exit 1 ;;
                        I|i) test -f $dest && rm $dest; echo -e "\n"
                             git checkout -- $dest 2>/dev/null
                             break ;;
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
${HOME}/.xinitrc
${HOME}/.conkyrc
${HOME}/.termlogo
${HOME}/.nvidia-settings-rc
${HOME}/.config.kernel
${HOME}/.config/fish/config.fish
${HOME}/.config/compton.conf

# Openbox
${HOME}/.config/openbox/autostart
#${HOME}/.config/openbox/menu.xml
${HOME}/.config/openbox/rc.xml

# /etc
/etc/iptables/iptables.rules
/etc/netctl/cabo
/etc/adobe/mms.cfg
/etc/bash/bashrc
/etc/dhcpcd.conf
/etc/hostname
/etc/vconsole.conf
/etc/locale.conf
/etc/resolvconf.conf
/etc/sysctl.d/99-sysctl.conf
#/etc/asound.conf
#/srv/squid
#/etc/sudoers

# Xorg
/etc/X11/xorg.conf.d/20-nvidia.conf
/etc/X11/xorg.conf.d/20-samsung.conf
/etc/X11/xorg.conf.d/20-screen.conf

# systemd-units
/etc/systemd/system/xinit-login.service

# boot
/boot/extlinux/extlinux.conf

); echo -e "Concluído.\n"

echo -n "Verificando arquivos... "; checkfiles "$1"; echo -e "Concluído.\n"

echo "Tarefa completada com sucesso!"
exit 0

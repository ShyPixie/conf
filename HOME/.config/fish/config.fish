# Lara Maia <lara@craft.net.br> © 2015
#
# Depends: cdf             [aur]
#          grc             [repo]
#          netcat          [repo[
#          colordiff       [repo]
#          time            [repo]
#          geany           [time]
#          geany_checkpath [aur]
#          yaourt          [aur]

# ============== Configurações =======================

# Cores padrões
set fish_color_normal white
set fish_color_command green
set fish_color_redirection blue
set fish_color_end yellow -o
set fish_color_error red -o
set fish_color_match blue -o

# Cores do prompt
set __prompt_color_separator (set_color white)
set __prompt_color_user      (set_color purple)
set __prompt_color_hostname  (set_color green)
set __prompt_color_pwd       (set_color yellow)
set __prompt_color_good      (set_color -o green)
set __prompt_color_bad       (set_color -o red)

# XDG
set -x XDG_CONFIG_HOME "$HOME"/.config

# Configuração do histórico
set -x HISTCONTROL "ignoredups"
set -x HISTSIZE "10000"
set -x HISTFILESIZE "20000"
set -x HISTIGNORE "bg:fg:exit:cd:ls:la:ll:ps:history:historytop:sudo:su:..:...:....:....."

# Cores para o grep, egrep e zgrep
set -x grep --color=always
set -x egrep --color=always
set -x zgrep --color=always

# =============== Aliases =========================

# Dir list
function ls; /usr/bin/ls -h --group-directories-first --color='auto' $argv; end
function ll; lp $argv; end
function la; lp -a $argv; end

function ..; cd ..; end
function ...; cd ../..; end
function ....; cd ../../..; end
function .....; cd ../../../..; end

function back; cd (echo $PWD | rev | cut -d"/" -f2- | rev); end
function back2; cd $PWD; end
function reload; . ~/.config/fish/config.fish; end
function edit; geany ~/.config/fish/config.fish; end

# Operações de arquivos
function rm; /usr/bin/rm -vI --preserve-root $argv; end
function mv; /usr/bin/mv -vi $argv; end
function cp; /usr/bin/cp -vi $argv; end
function ln; /usr/bin/ln -i $argv; end
function du; /usr/bin/du -h $argv; end
function df; cdf -mh | grep -v -e '0 /' -e rootfs -e cgroup -e 1000 | sed 's/devtmpfs/  tmpfs/'; end

function chown; /usr/bin/chown --preserve-root $argv; end
function chmod; /usr/bin/chmod --preserve-root $argv; end
function chgrp; /usr/bin/chgrp --preserve-root $argv; end

function geany; geany_checkpath $argv; end
function yaourt; yaourt_wrapper $argv; end
function pacman; yaourt_wrapper $argv; end

function orphans; pacman -Rcns (pacman -Qqtd); end
function termbin; nc termbin.com 9999; end

# Ferramentas
function diff; colordiff $argv; end
function allmounts; mount | column -t; end
function time; /usr/bin/time -p /bin/fish -c $argv; end
function pacmanunlock; sudo rm -f /var/lib/pacman/db.lck; end

# Kill
function k; killall $argv; end
function kf; killall -9 $argv; end
function k9; killall -9 $argv; end

# Listagem de processos
function psc; ps xawf -eo pid,user,cgroup,args; end
function psd; systemd-cgls; end

# Power
function reboot; systemctl reboot; end
function shutdown; systemctl poweroff; end

# Cores com grc
function configure; grc -es --colour=auto ./configure $argv; end
function make; grc -es --colour=auto make $argv; end
function gcc; grc -es --colour=auto gcc $argv; end
function g++; grc -es --colour=auto g++ $argv; end
function ld; grc -es --colour=auto ld $argv; end
function netstat; grc -es --colour=auto netstat $argv; end
function ping; grc -es --colour=auto ping -c 3 $argv; end
function traceroute; grc -es --colour=auto traceroute $argv; end

# ============== Funções ==========================

# http://unixcoders.wordpress.com/2013/02/12/print-numerical-permissions-of-files/
function lp -d "Permissões numéricas no ls"
    ls -lh $argv | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) \
                *2^(8-i));if(k)printf("%0o ",k);print}'
end

# https://gist.github.com/87359
function historytop -d "Top 10"
    history | awk '{a[$2]++}END{for(i in a){printf"%5d\t%s\n",a[i],i}}' | sort -nr | head
end

function githardmv -d "Forçar git mv"
    git checkout -- $argv[1] 1>/dev/null
    git mv $argv[1] $argv[2] 1>/dev/null
    echo "$argv[1] -> $argv[2]"
end

function superretab -d "super retab"
    for file in (find $argv -type f -not -iwholename '*.git*')
        sed -i 's/\t/    /g' $file; or exit 1
        echo "$file retabed"
    end
end

function yaourt_wrapper -d "yaourt wrapper for rsync db with xfer"
    set -l CONF /etc/pacman.conf
    set -l temp (mktemp)
    set -l refresh 0
    set -l update 0

    switch $argv[1]
        case "-Sy"
            set refresh 1
        case "-Syu" "-Suy"
            set refresh 1
            set update 1
        case '*'
            command yaourt $argv
    end

    if test $refresh -eq 1
        cat $CONF | grep -v Xfer | sudo tee $temp >/dev/null ; or exit 1
        sudo pacman -S --config $temp -y ; or exit 1
    end

    if test $update -eq 1
        command yaourt -Su
    end
end


# ---- ~ ----

function fish_greeting -d "motd"
    alsi -ub -f
end

function fish_prompt -d "Prompt"
    set laststatus $status

    # u+168b/u+169c/u+169b/u+168b
    printf '%s%s%s%s@%s%s%s: %s%s ' \
           $__prompt_color_separator \
           $__prompt_color_user      \
           $USER                     \
           $__prompt_color_separator \
           $__prompt_color_hostname  \
           (hostname)                \
           $__prompt_color_separator \
           $__prompt_color_pwd       \
           (echo $PWD | sed -e "s|^$HOME|~|")

    if test $laststatus -eq 0
        printf "%s:) " $__prompt_color_good
    else
        printf "%s:( " $__prompt_color_bad
    end

    printf "%s" (set_color normal)
end

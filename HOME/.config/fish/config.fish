# Lara Maia <lara@craft.net.br> © 2015
#
# Depends: sys-fs/cdf        [overlay{LaraCraft93}]
#          grc               [repo]
#          netcat            [repo]
#          colordiff         [repo]
#          sys-process/time  [repo]
#          vim               [repo]
#          xmodmap           [repo]
#          file              [repo]

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

# map super to esc
xmodmap -e "keysym Super_R = Escape" 2>/dev/null

# ============ Váriaveis Adicionais ===============

set -g steamwine_prefix $HOME/.local/share/wineprefixes/steam
set -g steamwine_path "$steamwine_prefix/drive_c/Program Files (x86)/Steam"
set -g steamwine_gamespath "$steamwine_path/steamapps/common"

set -g github http://github.com
set -g githublara $github/LaraCraft93
set -g gh $github
set -g ghl $githublara

# =============== Aliases =========================

function grep; command grep --color=always $argv; end
function egrep; command egrep --color=always $argv; end
function zgrep; command zgrep --color=always $argv; end

# Dir list
function ls; command ls -h --group-directories-first --color='auto' --indicator-style=classify $argv; end
function ll; lp $argv; end
function la; lp -a $argv; end
function perms; lp -ld $argv; end
function types; file *; end

function ..; cd ..; end
function ...; cd ../..; end
function ....; cd ../../..; end
function .....; cd ../../../..; end

function back; cd (echo $PWD | rev | cut -d"/" -f2- | rev); end
function back2; cd $PWD; end
function reload; . ~/.config/fish/config.fish; end
function edit; vim ~/.config/fish/config.fish; end
function editworld; sudo vim /var/lib/portage/world; end
function editmake; sudo vim /etc/portage/make.conf; end
function edituse; sudo vim /etc/portage/package.use; end
function editmask; sudo vim /etc/portage/package.mask; end
function editunmask; sudo vim /etc/portage/package.unmask; end
function editkey; sudo vim /etc/portage/package.accept_keywords; end

# Operações de arquivos
function rm; command rm -vI --preserve-root $argv; end
function mv; command mv -vi $argv; end
function cp; command cp -vi $argv; end
function ln; command ln -i $argv; end
function du; command du -h $argv; end
function df; cdf -mh | grep -v -e '0 /' -e rootfs -e cgroup -e 1000 | sed 's/devtmpfs/  tmpfs/'; end

function chown; command chown --preserve-root $argv; end
function chmod; command chmod --preserve-root $argv; end
function chgrp; command chgrp --preserve-root $argv; end

# Ferramentas
function termbin; nc termbin.com 9999; end
function tb; termbin; end
function diff; colordiff $argv; end
function allmounts; mount | column -t; end
function time; command time -p /bin/fish -c $argv; end
function e; equery $argv; end
function sudo; command sudo -s $argv; end
function eix-sync; eval /home/lara/Develop/tools/portage_excludes.sh; and command eix-sync $argv; end

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

function reinstallcat -d "Reinstala todos os pacotes de uma determinada categoria."
    set -l packages (eix -IA --only-names $argv[1])
    sudo emerge -1 $packages
end

function catebuild -d "Mostra o conteúdo de um arquivo ebuild através do nome"
    set -l eb (equery w $argv[1])
    set -l ebst $status
    if count $argv[1] >/dev/null
        if test $ebst -eq 0
            cat "$eb"
        else
            echo -n "$eb"
        end
    end
end

# Se for uma conexão ssh, executar o tmux
if test ! -z "$SSH_TTY" -a -z "$STY"
    tmux -2 new-session -A -s ssh -t principal
end

function exit -d "Sair da sessão do ssh sem fechar o terminal"
    if test "$TERM" = "screen-256color" -a \
    (tmux display-message -p '#S') = "ssh"
        tmux detach -P
    else
        tmux detach -P -s ssh
        builtin exit
    end
end

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

function gitatomdiff -d "Mostrar o diff no atom"
    git diff > /tmp/gitatomdiff.diff; and \
    atom /tmp/gitatomdiff.diff; and \
    sleep 10; and \
    rm -f /tmp/gitatomdiff.diff
end

function superretab -d "super retab"
    for file in (find $argv -type f -not -iwholename '*.git*')
        sed -i 's/\t/    /g' $file; or exit 1
        echo "$file retabed"
    end
end

function execinfolder -d "Executa o comando em todos os arquivos na pasta"
    for file in (find . -type f -not -iwholename '*.git*')
        eval $argv $file; or exit 1
        echo "Executando: $argv $file"
    end
end

# ---- ~ ----

function fish_greeting -d "motd"
    if test (id -u) != 0
       cat "$HOME"/.termlogo | xargs -0 echo -e
    end
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

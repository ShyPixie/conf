# Lara Maia <lara@craft.net.br> © 2013

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

# Configuração do histórico
set -x HISTCONTROL "ignoredups"
set -x HISTSIZE "10000"
set -x HISTFILESIZE "20000"
set -x HISTIGNORE "bg:fg:exit:cd:ls:la:ll:ps:history:historytop:sudo:su:..:...:....:....."

# Cores para o grep, egrep e zgrep
set -x GREP_OPTIONS "--color=auto"

# map super to esc
xmodmap -e "keysym Super_R = Escape"

# =============== Aliases =========================

# Dir list
function ls; command ls -h --group-directories-first --color='auto' $argv; end
function ll; lp -l $argv; end
function la; lp -a $argv; end
function perms; lp -ld $argv; end

function ..; cd ..; end
function ...; cd ../..; end
function ....; cd ../../..; end
function .....; cd ../../../..; end

function back; cd (echo $PWD | rev | cut -d"/" -f2- | rev); end
function reload; . ~/.config/fish/config.fish; end
function edit; geany ~/.config/fish/config.fish; end

# Operações de arquivos
function rm; command rm -vI --preserve-root $argv; end
function mv; command mv -vi $argv; end
function cp; command cp -vi $argv; end
function ln; command ln -i $argv; end
function du; command du -h $argv; end

function chown; command chown --preserve-root $argv; end
function chmod; command chmod --preserve-root $argv; end
function chgrp; command chgrp --preserve-root $argv; end

function geany; geany_checkpath $argv; end

# Ferramentas
function diff; colordiff $argv; end
function allmounts; mount | column -t; end

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

# Fix sudo aliases (without fish default shell)
function sudo; command sudo -s /bin/fish -c "$argv"; end

# Fix time
function time; command time -p /bin/fish -c $argv; end

# ============== Funções ==========================

# http://unixcoders.wordpress.com/2013/02/12/print-numerical-permissions-of-files/
function lp -d "Permissões numéricas no ls"
    ls -h $argv | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) \
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

# ---- ~ ----

function fish_greeting -d "motd"
    if test (id -u) != 0
       cat "$HOME"/.termlogo | xargs -0 echo -e
    end
end

function fish_prompt -d "Prompt"
    set laststatus $status

    # u+168b/u+169c/u+169b/u+168b
    printf '%sᚋ᚜%s%s%s᚛᚜%s%s%s᚛ᚋ %s%s ' \
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

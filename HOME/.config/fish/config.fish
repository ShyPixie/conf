# Lara Maia <dev@lara.click> © 2018
# fish config for msys2
# PATH
#set -xg PATH /c/Program\ Files/Docker/Docker/Resources/bin /c/Program\ Files\ \(x86\)/gnupg/bin /c/Program\ Files\ \(x86\)/Gpg4win/bin /mingw64/bin /usr/bin /bin /usr/local/bin /c/Windows /c/Windows/system32
set -xg PATH /mingw64/bin /usr/bin /bin /usr/local/bin /c/Windows /c/Windows/system32

# DISPLAY
set -xg DISPLAY :0

# GPG Authentication
#set -xg GNUPGHOME /c/Users/Lara/AppData/Roaming/gnupg
#eval (/usr/bin/ssh-pageant -cra "/tmp/.ssh-pageant-Lara")
set -xg SSH_AUTH_SOCK /home/lara/.gnupg/S.gpg-agent.ssh
set -xg GPG_TTY (tty)
gpgconf --launch gpg-agent

set -xg HOME2 /c/Users/Lara

# Colors
set fish_color_normal white
set fish_color_command green
set fish_color_redirection blue
set fish_color_end yellow -o
set fish_color_error red -o
set fish_color_match blue -o

# XDG
set -x XDG_CONFIG_HOME /c/Users/Lara/.config

# History
set -x HISTCONTROL "ignoredups"
set -x HISTSIZE "10000"
set -x HISTFILESIZE "20000"
set -x HISTIGNORE "bg:fg:exit:cd:ls:la:ll:ps:history:historytop:sudo:su:..:...:....:....."

# Github
set -g gh https://github.com
set -g ghl git@github.com:ShyPixie
set -g ghr git@github.com:RaspberryLove
set -g ghth git@github.com:TOSHACK

# mingw
set -g mingwpkg mingw-w64-x86_64
set -g mingwpkg32 mingw-w64-i686

# =============== Aliases =========================

function grep; command grep --color=always $argv; end
function egrep; command egrep --color=always $argv; end
function zgrep; command zgrep --color=always $argv; end

# Dir list
function ls; lp $argv; end
function ll; lp -l $argv; end
function la; lp -a $argv; end
function perms; lp -ld $argv; end
function types; file *; end
function tree; command tree -C $argv; end

function .; cd ..; end
function ..; cd ../..; end
function ...; cd ../../..; end
function ....; cd ../../../..; end

function back; cd (echo $PWD | rev | cut -d"/" -f2- | rev); end
function back2; cd $PWD; end
function reload; source ~/.config/fish/config.fish; end
function edit; vim ~/.config/fish/config.fish; end

function notepad++; /c/Program\ Files/Notepad++/Notepad++.exe $argv; end
function note; notepad++ $argv; end
function winrar; /c/Program\ Files/WinRAR/WinRAR.exe $argv; end

function cd; builtin cd $argv; and ls; end
function rm; command rm -vI --preserve-root $argv; end
function mv; command mv -vi $argv; end
function cp; command cp -vi $argv; end
function ln; command ln -i $argv; end
function du; command du -h $argv; end

function chown; command chown --preserve-root $argv; end
function chmod; command chmod --preserve-root $argv; end
function chgrp; command chgrp --preserve-root $argv; end

function diff; colordiff $argv; end
function allmounts; mount | column -t; end

function psc; ps xawfe; end

function exit; kill (pgrep -u $USER); end

# ============== Useful functions ==========================

function lp -d "ls with numerical permissions"
    if not contains -- -l $argv
        command ls $argv --color=always -h --group-directories-first --indicator-style=classify
    else
        echo -e (/bin/ls $argv -h --group-directories-first --indicator-style=classify | awk \
          '{k=0
            for(i=0; i<=8; i++) {
                k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i))
            }

            if(k) {
                split($0, lsInfo, " ", sep)
                printf("\033[01;32m%0o \033[m", k)
                printf("\033[00;33m%s%s", lsInfo[1], sep[1])
                printf("\033[01;34m%s%s", lsInfo[2], sep[2])
                printf("\033[01;35m%s%s", lsInfo[3], sep[3])
                printf("\033[00;35m%s%s", lsInfo[4], sep[4])
                printf("\033[m%s%s", lsInfo[5], sep[5])
                printf("%s%s", lsInfo[6], sep[6])
                printf("%s%s", lsInfo[7], sep[7])
                printf("%s%s", lsInfo[8], sep[8])
                printf("\033[00;33m%s%s", lsInfo[9], sep[9])
                printf("%s%s", lsInfo[10], sep[10])
                printf("%s%s", lsInfo[11], sep[11])
                printf("\033[m\\\n")
            }
           }
         ')
    end
end

function docker_remove_all -d "Remove all images and containers from docker"
    docker rm (docker ps -a -q) --force
    docker rmi (docker images -q) --force
end

# ---- ~ ----

function fish_greeting -d "motd"
    if test (id -u) != 0
       echo -e (cat "$HOME"/.termlogo)
    end
end

function fish_prompt -d "Prompt"
    set laststatus $status

    set c_white (set_color white)
    set c_purple (set_color purple)
    set c_green (set_color green)
    set c_yellow (set_color yellow)
    set c_b_green (set_color -o green)
    set c_b_red (set_color -o red)

    set my_cwd (echo $PWD | sed -e "s|^$HOME|~|")

    printf "$c_purple%s$c_white@$c_green%s: $c_yellow%s " $USER (hostname) $my_cwd

    if test $laststatus -eq 0
        printf "$c_b_green:) "
    else
        printf "$c_b_red:( "
    end

    printf (set_color normal)
end

#
# ~/.bashrc
#
# Lara Maia <lara@craft.net.br> © 2013 :c)

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Bash completation
source /usr/share/bash-completion/bash_completion

# Command not found
source /usr/share/doc/pkgfile/command-not-found.bash

# XDG
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_MENU_PREFIX="xfce-"

# Fortunes
cowthink -$(shuf -n 1 -e b d p s w y) -f small $(fortune /usr/share/fortune/brasil)

# Bash setup
shopt -s autocd
shopt -s checkwinsize
shopt -s extglob

# History setup
shopt -s histappend
shopt -s cmdhist
export HISTCONTROL=ignoredups
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTIGNORE="bg:fg:exit:cd:ls:la:ll:ps:history:historytop:sudo:su:..:...:....:....."

# Color for grep, egrep and zgrep
export GREP_OPTIONS='--color=auto'

# Functions --------------------------------------------- #

# Colorize man pages
# https://wiki.archlinux.org/index.php/Man_Page#Colored_man_pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}
    
# Show numerical permissions in ls
# (http://unixcoders.wordpress.com/2013/02/12/print-numerical-permissions-of-files/)
lp() {
	ls -lh $@ | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) \
                *2^(8-i));if(k)printf("%0o ",k);print}'
}

# Show history summary (https://gist.github.com/87359)
historytop() {
	history | awk '{a[$2]++}END{for(i in a){printf"%5d\t%s\n",a[i],i}}' | sort -nr | head
}

# Git
githardmv() {
	git checkout -- $1 1>/dev/null
	git mv $1 $2 1>/dev/null
	echo "$1 -> $2"
}

# Aliases --------------------------------------------- #
alias sudo='sudo ' # fix completation for sudo

# Packages
alias yaourt='yaourt_wrapper'
alias pacaur='pacaur_wrapper'

# Dir list
alias ls='ls -h --group-directories-first --color=auto'
alias ll="lp"
alias la="lp -a"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias back='cd ${PWD%/*}'
alias reload='source /etc/bash.bashrc'

# File operations
alias rm='rm -vI --preserve-root'
alias mv='mv -vi'
alias cp='cp -vi'
alias ln='ln -i'
alias du='du -h'
alias df='df -h'

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias geany='geany_checkpath'

# Tools
alias diff='colordiff'
alias allmounts='mount | column -t'
alias ping='ping -c 5'
#alias grep='grep --color=auto' # already in GREP_OPTIONS

# Kill
alias k='killall'
alias kf='killall -9'
alias k9='killall -9'

# List processes
alias psc='ps xawf -eo pid,user,cgroup,args'
alias psd='systemd-cgls'

# Power
alias reboot='systemctl reboot'
alias restart='systemctl restart'
alias shutdown='systemctl poweroff'

# Others colors if grc is installed
if which grc &>/dev/null; then
    alias configure='grc -es --colour=auto ./configure'
    alias diff='grc -es --colour=auto diff'
    alias make='grc -es --colour=auto make'
    alias gcc='grc -es --colour=auto gcc'
    alias g++='grc -es --colour=auto g++'
    alias ld='grc -es --colour=auto ld'
    alias netstat='grc -es --colour=auto netstat'
    alias ping='grc -es --colour=auto ping -c 10'
    alias traceroute='grc -es --colour=auto traceroute'
fi

# Colors ----------------------------------------------- #

# Normal Colors
Black="\e[0;30m"  
Red="\e[0;31m"    
Green="\e[0;32m"  
Yellow="\e[0;33m" 
Blue="\e[0;34m"   
Purple="\e[0;35m" 
Cyan="\e[0;36m"   
White="\e[0;37m"  

# Intense Colors
IBlack="\e[0;90m" 
IRed="\e[0;91m"   
IGreen="\e[0;92m" 
IYellow="\e[0;93m"
IBlue="\e[0;94m"  
IPurple="\e[0;95m"
ICyan="\e[0;96m"  
IWhite="\e[0;97m" 

Off="\e[m"

# PS1 -------------------------------------------------- #

p="$IYellow\w"
tm="$IGreen:)"
fm="$IRed:("
s="᚜᚛" # u+169c/u+169b
h="$IGreen\h"

if [ `id -u` != 0 ]; then
   tg="$IWhite\$ "
   lc=$IWhite
   u="$IPurple\u"
else
   tg="$IRed# "
   lc=$IBlue
   u="$IRed\u"
fi

# Legend
# 
# s = separator
# tg = ps1 tag
# lc = line color
# ac = arrow color
# h = hostname
# p = path
# u = user
# tm = true emotion
# fm = false emotion
# Off = color off

# u+168b/u+168b
export PS1="$lc ᚋ${s:0:1}$u$lc${s:1:1}${s:0:1}$h$lc${s:1:1}ᚋ $p \$(if [ \$? -ne 0 ]; then echo \"$fm\"; else echo \"$tm\"; fi) $tg$Off"

#
# ~/.bashrc
#
# Lara Maia <lara@craft.net.br> © 2013 :c)

# Bash completation
source /usr/share/bash-completion/bash_completion
	
# XDG
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_MENU_PREFIX="xfce-"

# Fortunes
cowsay $(fortune /usr/share/fortune/brasil)&&echo

# Bash setup
shopt -s autocd
shopt -s checkwinsize
shopt -s extglob

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
lp() {
	ls -lh | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) \
             *2^(8-i));if(k)printf("%0o ",k);print}'
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

# File operations
alias rm='rm -vI --preserve-root'
alias mv='mv -vi'
alias cp='cp -vi'
alias ln='ln -i'

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias geany='geany_checkpath'

# Tools
alias diff='colordiff'
alias mount='mount | column -t'
alias ping='ping -c 5'
alias grep='grep --color=auto'

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

# Colors ----------------------------------------------- #

# Normal Colors
Black="\[\033[0;30m\]"  
Red="\[\033[0;31m\]"    
Green="\[\033[0;32m\]"  
Yellow="\[\033[0;33m\]" 
Blue="\[\033[0;34m\]"   
Purple="\[\033[0;35m\]" 
Cyan="\[\033[0;36m\]"   
White="\[\033[0;37m\]"  

# Intense Colors
IBlack="\[\033[0;90m\]" 
IRed="\[\033[0;91m\]"   
IGreen="\[\033[0;92m\]" 
IYellow="\[\033[0;93m\]"
IBlue="\[\033[0;94m\]"  
IPurple="\[\033[0;95m\]"
ICyan="\[\033[0;96m\]"  
IWhite="\[\033[0;97m\]" 

Color_Off="\[\033[m\]"

# PS1 -------------------------------------------------- #

Time12h="\T"
PathShort="\w"

if [ `id -u` == 0 ]; then
  _linecolor=$IRed
  _seta=$IRed
  _hostname=$ICyan
  _ps1_nl_tg="└─${_seta}>>"
  _separator="[]"
else
  _linecolor=$Red
  _seta=$White
  _hostname=$IBlue
  _ps1_nl_tg="└─${_seta}>>"
  _separator="<>"
fi

export PS1="$_linecolor┌─\
${_separator:0:1}$IPurple\\u$_linecolor${_separator:1:1}\
-${_separator:0:1}$_hostname\\h$_linecolor${_separator:1:1}\
-${_separator:0:1}$IGreen$Time12h$_linecolor${_separator:1:1}\
 $Yellow$PathShort${_linecolor}
${_ps1_nl_tg} ${IBlue}$Color_Off"

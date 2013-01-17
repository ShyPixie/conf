#
# ~/.bashrc
#
# Autor: Lara Maia - Lara Maia <lara@craft.net.br>

# Iniciar o X ao logar no tty1
#if [ $(tty) == "/dev/tty1" ]; then
#  echo "Iniciando a interface gráfica..."
#	xinit >/dev/null 2>&1 & # configuração em ~/.xinitrc
#  echo "Overclokando GPU..."
#  nvidia-settings --display=:0.0 -a GPUOverclockingState=1
#  nvidia-settings --display=:0.0 --assign="GPU3DClockFreqs=630,1007"
#fi

# Ativar completações do bash
[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# Transparência do terminal
#transset-df -a 0.7 >/dev/null

# Fortunes
echo&&fortune /usr/share/fortune/brasil&&echo

# Aliases
alias sudo='sudo '
alias yaourt='yaourt_wrapper'
alias ls='ls --group-directories-first -h --color=auto'
alias la='ls -lha --group-directories-first -h --color=auto'
alias lo='ls -a --group-directories-first -h --color=auto'
alias grep='grep --color=auto'
alias pacman='pacman-color'
alias k='killall'
alias kf='killall -9'
alias k9='killall -9'
alias rm='rm -vi'
alias mv='mv -vi'
alias cp='cp -vi'
alias geany='geany_checkpath'
alias psc='ps xawf -eo pid,user,cgroup,args'
alias psd='systemd-cgls'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

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

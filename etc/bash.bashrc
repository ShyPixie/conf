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

# Correção de vídeos azuis
#export VDPAU_NVIDIA_NO_OVERLAY=1

# Aliases
alias sudo='sudo '
#alias yaourt='yaourt-mktmp'
alias ls='ls --color=auto'
alias pacman='pacman-color'
alias mv='mv -v'
alias cp='cp -v'
#alias geany='geany_subprocess'
alias psc='ps xawf -eo pid,user,cgroup,args'
alias psd='systemd-cgls'

Black="\[\033[0;30m\]"  
Red="\[\033[0;31m\]"    
Green="\[\033[0;32m\]"  
Yellow="\[\033[0;33m\]" 
Blue="\[\033[0;34m\]"   
Purple="\[\033[0;35m\]" 
Cyan="\[\033[0;36m\]"   
White="\[\033[0;37m\]"  

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
	_ps1_nl_tg="└─${_seta}⊳"
else
  _linecolor=$Red
  _seta=$White
  _hostname=$IBlue
	_ps1_nl_tg="└─${_seta}⊳"
fi

function __git_ps1() {
local b="$(git symbolic-ref HEAD 2>/dev/null)"
if [ -n "$b" ]; then
	if [ -n "$1" ]; then
		printf "$1" "${b##refs/heads/}"
	else
		printf " (%s)" "${b##refs/heads/}"
	fi
fi
}

export PS1=$_linecolor┌─[$IPurple\\u$_linecolor]─[$_hostname\\h$_linecolor]─[$IGreen$Time12h$_linecolor]$Color_Off'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # Repositorio limpo (nada para commitar)
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    # Mudanças no tree atual
    echo "'$IRed'"$(__git_ps1 " {%s}"); \
  fi) '$Yellow$PathShort${_linecolor}\\n${_ps1_nl_tg}\ ${IBlue}#$Color_Off' "; \
else \
  # Não é repositório git
  echo " '$Yellow$PathShort${_linecolor}\\n${_ps1_nl_tg}${IBlue}$Color_Off' "; \
fi)'



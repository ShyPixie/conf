[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
export GTK2_RC_FILES="/etc/gtk-2.0/gtkrc:$HOME/.gtkrc-2.0"
setxkbmap -model abnt2 br
nitrogen --restore
nvidia-settings -a GPUOverclockingState=1
nvidia-settings -a GPU3DClockFreqs=650,800
exec ck-launch-session openbox-session

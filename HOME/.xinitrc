[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
setxkbmap -model abnt2 br -option compose:rwin

# Temp fix sudo
xhost local:root

startfluxbox

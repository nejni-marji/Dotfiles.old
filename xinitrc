#
# ~/.xinitrc
#

export EDITOR=vim
export TERMINAL=urxvt
export QT_QPA_PLATFORMTHEME=gtk2
exec i3 -V 2>&1 >~/.i3/i3log.txt

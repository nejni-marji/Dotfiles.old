#!/bin/bash

laptop() {
	mons -o
	#DPI=96
	pgrep -x redshift-gtk || redshift-gtk &
}

hdmi() {
	mons -s
	DPI=144
	pgrep -x redshift-gtk; pkill -x redshift-gtk; redshift -x
}

mons | grep HDMI || exit
mons | grep LVDS1 || exit
mons | grep '0.*enabled' && hdmi || laptop

OUTPUT=$(xrandr | grep -P '([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+)' | awk '{print $1}')
[[ -z "$DPI" ]] && DPI=96
DPI="$DPI"x"$DPI"
xrandr --output $OUTPUT --primary --dpi $DPI

i3-msg restart
setpaper
pgrep -x compton && pkill -x compton && compton -b || compton -b
pkill telegram && telegram-desktop

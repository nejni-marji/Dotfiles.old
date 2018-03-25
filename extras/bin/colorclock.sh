#!/bin/bash
#
# colorclock.sh
#

# colorclock.sh v0.8
# Written by nejni marji.
# Distributed under the GNU GPLv2.
# <https://www.gnu.org/licenses/gpl-2.0.txt>

# There's 3 algorithms you can use to make a hex color clock.
# 1 is percent, 2 is direct, 3 is hex
#
# The sample time to be used is 15:27:13 (randomly generated).
# 1) #A67438 -- use each value as a percent (23:00:00 is #FF0000)
# 2) #152713 -- use each value directly
# 3) #0F1B0D -- convert each value to hex first

usage1='Usage: colorclock.sh'
usage1+=' [-m {p|percent|d|direct|h|hex}]'
usage1+=' [-t delay]'
usage1+=' [-vdsor]'
usage1+=' [-h]'
usage2='Flags:'
usage2+=' [m]ethod,'
usage2+=' [t]ime of delay,'
usage2+=' [v]erbose,'
usage2+=' [d]ebug,'
usage2+=' [s]imulate,'
usage2+=' [o]neshot,'
usage2+=' [r]andomize,'
usage2+=' [h]elp'

opt_m=percent
opt_t=1
opt_v=false
opt_d=false
opt_s=false
opt_o=false
opt_r=false

while getopts ":m:t:vdsorh" opt; do
	case "${opt}" in
		m)
			opt_m=$OPTARG
		;;
		t)
			[[ $OPTARG =~ ^[1-9][0-9]+?$ ]] \
			&& opt_t=$OPTARG
		;;
		v)
			opt_v=true
		;;
		d)
			opt_d=true
		;;
		s)
			opt_s=true
		;;
		o)
			opt_o=true
		;;
		r)
			opt_r=true
		;;
		h)
			echo $usage1
			echo $usage2
			exit
		;;
	esac
done

method_percent() {
	echo -n $(echo "obase=16; $(date -d $current +%H)*255/23" | bc | perl -pe 's/^(?=.$)/0/')
	echo -n $(echo "obase=16; $(date -d $current +%M)*255/59" | bc | perl -pe 's/^(?=.$)/0/')
	echo -n $(echo "obase=16; $(date -d $current +%S)*255/59" | bc | perl -pe 's/^(?=.$)/0/')
	echo
}

method_direct() {
	date -d $current +%H%M%S
}

method_hex() {
	echo -n $(echo "obase=16; $(date -d $current +%H)" | bc | perl -pe 's/^(?=.$)/0/')
	echo -n $(echo "obase=16; $(date -d $current +%M)" | bc | perl -pe 's/^(?=.$)/0/')
	echo -n $(echo "obase=16; $(date -d $current +%S)" | bc | perl -pe 's/^(?=.$)/0/')
	echo
}

randomize_color() {
	RANDOM=$(date +%Y%m%d)
	#RANDOM=4730 #TODO
	orders=('\1\2\3' '\1\3\2' '\2\1\3' '\2\3\1' '\3\1\2' '\3\2\1')
	order=${orders[$(($RANDOM%6))]}
	color=$(echo $color | perl -pe "s/^(..)(..)(..)$/$order/")
}

case $opt_m in
	d|direct)
		get_color=method_direct
		method=direct
		desc='use each value as the absolute value of each color'
	;;
	h|hex)
		get_color=method_hex
		method=hex
		desc='convert each value to hex, then use it as a color value'
	;;
	p|percent|*)
		get_color=method_percent
		method=percent
		desc='use each value as a percent of each color'
	;;
esac

$opt_v && echo "Starting colorclock.sh using the $method method: $desc." >&2

cache=~/Media/Cache/clocks
mkdir -p $cache

set_wallpaper() {
	file="$cache/$color.png"
	[[ -f $file ]] || \
	convert canvas:\#$color $file
	feh --bg-scale $file
}

do_loop() {
	current="$(date +%H:%M:%S)"
	$opt_d && current='15:27:13' # sample time
	color=$($get_color)
	$opt_r && randomize_color
	$opt_v && echo \#$color
	$opt_s && return 0
	set_wallpaper $color
}

do_loop
$opt_d || $opt_o && exit
while sleep $opt_t; do
	do_loop
done

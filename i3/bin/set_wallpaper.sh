#!/bin/bash
case $(hostname) in
	Desktop.Arch)
		feh --bg-scale ~/.wallpaper/astronomy/earth/usa_nighttime_1920x1080.png
		;;
	ASUS|Toshiba)
		feh --bg-scale ~/.wallpaper/ftl/kestrel_by_andrewcolunga_1366x768.png
		;;
	*)
		feh --bg-scale ~/.wallpaper/default.png
		;;
esac

#!/bin/bash
case $(hostname) in
	Desktop)
		feh --bg-scale ~/.wallpaper/waluigi/too_bad_waluigi_time_1920x1080.png
		;;
	ASUS|Toshiba)
		feh --bg-scale ~/.wallpaper/ftl/kestrel_by_andrewcolunga_1366x768.png
		;;
	*)
		feh --bg-scale ~/.wallpaper/default.png
		;;
esac

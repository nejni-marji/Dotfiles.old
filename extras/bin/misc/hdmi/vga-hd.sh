#!/bin/bash
echo xrandr --output LVDS1 --mode 1366x768
echo '# Pipe this into a shell or run it in eval.'
cvt 1366 768 | sed -E 's/Modeline ([^ ]*)(.*)/xrandr --newmode \1\2\nxrandr --addmode VGA1 \1\nxrandr --output VGA1 --mode \1/'

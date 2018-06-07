#!/bin/bash
MATRIX="$1"
[[ -z $MATRIX ]] && MATRIX=0.2
ACCEL="$2"
[[ -z $ACCEL ]] && ACCEL=1

xinput set-prop Logitech\ M570 'Coordinate Transformation Matrix' $MATRIX 0 0 0 $MATRIX 0 0 0 1
xinput set-prop Logitech\ M570 'libinput Accel Speed' $ACCEL

xinput set-prop Logitech\ M570 'libinput Scroll Method Enabled' 0 0 1
xinput set-prop Logitech\ M570 'libinput Button Scrolling Button' 9

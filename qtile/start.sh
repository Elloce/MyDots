#!/bin/sh

picom --config ~/.config/picom/picom.conf -b &
xrandr -s 1920x1080
feh --bg-fill --randomize ~/Pictures/

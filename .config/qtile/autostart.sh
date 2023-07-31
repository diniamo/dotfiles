#!/bin/bash

setxkbmap hu

dunst &
if [[ -d "/sys/class/power_supply" ]]; then x-on-resize --config ~/.config/qtile/hdmi_toggle.sh & fi
redshift -l 47.1625:19.5033 &
betterlockscreen -u $WALLPAPER
xss-lock -- playerctl pause; betterlockscreen -l dimblur &

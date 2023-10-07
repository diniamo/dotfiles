#!/usr/bin/env dash

# Config
setxkbmap hu

# Background
dunst &
if [[ -d "/sys/class/power_supply" ]]; then x-on-resize --config ~/.scripts/hdmi_toggle.sh & fi
redshift -l 47.1625:19.5033 &
betterlockscreen -u $WALLPAPER &
xss-lock -- sh -c "playerctl -a pause; betterlockscreen -l dimblur" &

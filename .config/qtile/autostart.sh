#!/bin/bash

setxkbmap hu
dunst &
if [[ -d "/sys/class/power_supply" ]]; then x-on-resize --config ~/.config/qtile/hdmi_toggle.sh & fi

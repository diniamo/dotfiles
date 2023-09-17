#!/bin/bash

export PATH=/usr/bin

if [[ $(</sys/class/drm/card1-HDMI-A-1/status) == "connected" ]]
then
	pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:hdmi-stereo
	xrandr --output HDMI-1 --auto && xrandr --output eDP-1 --off
else
	pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo
	xrandr --output eDP-1 --auto && xrandr --output HDMI-1 --off
fi

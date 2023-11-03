#!/bin/sh

if [ $(cat /sys/class/drm/card1-HDMI-A-1/status) = "connected" ]
then
    hyprctl keyword monitor eDP-1,disabled
    pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:hdmi-stereo
else
    hyprctl keyword monitor eDP-1,1920x1080,0x0,1
    pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo
fi


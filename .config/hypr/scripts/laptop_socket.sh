#!/bin/sh

while read -r event; do
    case "$event" in
        monitoradded*|monitorremoved*)
            ~/.config/hypr/scripts/hdmi_hotplug.sh
    esac
done < <(socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock)

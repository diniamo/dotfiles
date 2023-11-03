#!/bin/sh

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r event; do
    action=$(printf '%s' "$event" | grep -oP '^.*(?=>>)')
    details=$(printf '%s' "$event" | grep -oP '^.*>>\K.*')

    case "$action" in
        monitoradded|monitorremoved)
            if printf '%s' "$details" | grep -q '^HDMI.*'; then
                ~/.config/hypr/scripts/hdmi_hotplug.sh
            fi
            ;;
    esac
done 

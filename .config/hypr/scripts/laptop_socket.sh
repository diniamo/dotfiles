#!/bin/bash

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r event; do
    action=${event%%>>*}
    details=${event##*>>}

    case "$action" in
        monitoradded|monitorremoved)
            if [[ "$details" == "HDMI*" ]]; then
                ~/.config/hypr/scripts/hdmi_hotplug.sh
            fi
            ;;
    esac
done 

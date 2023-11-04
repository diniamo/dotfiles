#!/bin/bash

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r event; do
    action=${event%%>>*}
    details=${event##*>>}

    case "$action" in
        openwindow)
            IFS=',' read -r -a details <<< "$details"

            if [[ "${details[3]}" != "File Manager" && "${details[1]}" == "special:fm" ]]; then
                hyprctl dispatch movetoworkspacesilent "$(hyprctl -j activeworkspace | jq -r '.id'),address:0x${details[0]}"
            fi
    esac
done


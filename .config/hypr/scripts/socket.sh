#!/bin/bash

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r event; do
    action=${event%%>>*}
    details=${event##*>>}

    case "$action" in
        openwindow)
            IFS=',' read -r -a details <<< "$details"

            if [[ "${details[3]}" != "File Manager" && "${details[1]}" == "special:fm" ]]; then
                hyprctl dispatch movetoworkspace "$(hyprctl -j activeworkspace | jq -r '.id'),address:0x${details[0]}"
                # hyprctl dispatch togglespecialworkspace
            fi
            ;;
        workspace)
            if hyprctl -j monitors | jq -e '.[] | select(.focused == true) | .specialWorkspace.id != 0'; then
                hyprctl dispatch togglespecialworkspace
            fi
            ;;
    esac
done


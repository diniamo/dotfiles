#!/bin/bash

update_window_decorations() {
    active=$(hyprctl -j activeworkspace)

    if jq -e '.hasfullscreen' <<< "$active"; then
        exit
    fi

    windows=$(jq -e '.windows' <<< "$active")
    if [[ $windows < 2 ]]; then
        ~/.config/hypr/scripts/workspace_decoration_manager.sh off
    else
        ~/.config/hypr/scripts/workspace_decoration_manager.sh on
    fi
}

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

            update_window_decorations
        ;;
        closewindow|movewindow)
            update_window_decorations
        ;;
        workspace)
            if hyprctl -j monitors | jq -e '.[] | select(.focused == true) | .specialWorkspace.id != 0'; then
                hyprctl dispatch togglespecialworkspace
            fi

            update_window_decorations
        ;;
        fullscreen)
            case "$details" in
                0)
                    ~/.config/hypr/scripts/workspace_decoration_manager.sh on
                ;;
                1)
                    ~/.config/hypr/scripts/workspace_decoration_manager.sh off
                ;;
            esac
        ;;
    esac
done


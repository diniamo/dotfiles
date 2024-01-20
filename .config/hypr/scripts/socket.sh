#!/bin/bash

update_window_decorations() {
    active=$(hyprctl -j activeworkspace)

    if jq -e '.hasfullscreen' <<<"$active"; then
        return
    fi

    # windows=$(jq -r '.windows' <<<"$active")
    windows=$(hyprctl -j clients | jq -r "[.[] | select(.workspace.id == $(jq -r '.id' <<<"$active") and .floating == false)] | length")
    if [ "$1" = true ]; then
        ((windows -= 1))
    fi

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
        IFS=',' read -r -a details <<<"$details"

        if [[ "${details[1]}" == "special:fm" && "${details[2]}" != *lf && "${details[2]}" != ueberzugpp_* ]]; then
            hyprctl dispatch movetoworkspace "$(hyprctl -j activeworkspace | jq -r '.id'),address:0x${details[0]}"
            # hyprctl dispatch togglespecialworkspace
        fi

        update_window_decorations
        ;;
    closewindow)
        update_window_decorations true
        ;;
    movewindow | changefloatingmode | configreloaded)
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
            update_window_decorations
            ;;
        1)
            ~/.config/hypr/scripts/workspace_decoration_manager.sh off
            ;;
        esac
        ;;
    esac
done

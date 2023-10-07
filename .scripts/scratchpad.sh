#!/usr/bin/env dash

TERMINAL_CMD="wezterm start --always-new-process"

windows_in(){
    hyprctl clients -j | jq ".[] | select(.workspace.name == \"special:$1\" )"
}

toggle_scratchpad(){
    workspace_name="$1"

    windows=$(windows_in "$workspace_name")
    if [ -z "$windows" ]; then
        shift
        for cmd in "$@"; do
            hyprctl dispatch "exec [workspace special:$workspace_name] $cmd"
        done
    else
        hyprctl dispatch togglespecialworkspace "$workspace_name"
    fi
}

if [ "$1" = "terminal" ]; then
    toggle_scratchpad "terminal" "$TERMINAL_CMD"
elif [ "$1" = "mixer" ]; then
    toggle_scratchpad "mixer" "$TERMINAL_CMD --title Mixer -- pulsemixer"
elif [ "$1" = "music" ]; then
    toggle_scratchpad "music" "$TERMINAL_CMD --title \"Music Player\" -- ncspot"
elif [ "$1" = "calculator" ]; then
    toggle_scratchpad "calculator" "$TERMINAL_CMD --title Calculator -- python -i -c \"from math import *\"" "$TERMINAL_CMD --title \"Wolfram Alpha\" -- ~/.scripts/loop_input.sh tungsten"
elif [ "$1" = "fm" ]; then
    toggle_scratchpad "fm" "$TERMINAL_CMD --title \"File Manager\" -- ranger"
fi

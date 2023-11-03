#!/bin/sh

# TERMINAL_CMD="wezterm start --always-new-process"
TERMINAL_CMD="kitty"

windows_in() {
    hyprctl clients -j | jq ".[] | select(.workspace.name == \"special:$1\" )"
}

toggle_scratchpad() {
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

case "$1" in
    "terminal")
        toggle_scratchpad "terminal" "$TERMINAL_CMD"
        ;;
    "mixer")
        toggle_scratchpad "mixer" "$TERMINAL_CMD --title Mixer -- pulsemixer"
        ;;
    "music")
        toggle_scratchpad "music" "$TERMINAL_CMD --title \"Music Player\" -- ncspot"
        ;;
    "calculator")
        toggle_scratchpad "calculator" "$TERMINAL_CMD --title Calculator -- qalc"
        ;;
    "wa")
        toggle_scratchpad "wa" "$TERMINAL_CMD --title \"Wolfram Alpha\" -- ~/.scripts/loop_input.sh 'wa -p'"
        ;;
    "fm")
        toggle_scratchpad "fm" "$TERMINAL_CMD --title \"File Manager\" -- lfrun"
        ;;
    "fm_gui")
        toggle_scratchpad "fm_gui" "dolphin"
        ;;
esac

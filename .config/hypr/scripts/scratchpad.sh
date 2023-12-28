#!/bin/sh

# TERMINAL_CMD="wezterm start --always-new-process"
TERMINAL_CMD="foot"
CLASS_ARGUMENT="--app-id"

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
    toggle_scratchpad "mixer" "$TERMINAL_CMD -- pulsemixer"
    ;;
"music")
    toggle_scratchpad "music" "$TERMINAL_CMD -- ncspot"
    ;;
"music_gui")
    toggle_scratchpad "music_gui" "spotify"
    ;;
"calculator")
    toggle_scratchpad "calculator" "$TERMINAL_CMD -- qalc"
    ;;
"wa")
    toggle_scratchpad "wa" "$TERMINAL_CMD -- ~/.scripts/loop_input.sh 'wa -p'"
    ;;
"fm")
    toggle_scratchpad "fm" "$TERMINAL_CMD $CLASS_ARGUMENT lf -- lfrun"
    ;;
"fm_gui")
    toggle_scratchpad "fm_gui" "dolphin"
    ;;
esac

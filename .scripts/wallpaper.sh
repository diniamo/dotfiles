#!/bin/sh

BACKGROUND_STATE_FILE="$HOME/.local/state/background"

pid="$(pgrep swaybg)"

if [ "$#" -lt 1 ]; then
    if [ -f "$BACKGROUND_STATE_FILE" ]; then
        image="$(cat "$BACKGROUND_STATE_FILE")"
    else
        echo "Background not set or is not a valid file! Please set one by passing its path to this script"
        exit 1
    fi
else
    image="$(realpath "$1")"
    printf '%s' "$image" > "$BACKGROUND_STATE_FILE"
fi

hyprctl dispatch -- exec swaybg --mode fill --image "$image"
sleep 1
kill -TERM "$pid"


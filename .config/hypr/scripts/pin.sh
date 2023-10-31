#!/bin/sh

floating=$(hyprctl -j activewindow | jq .floating)

if [ "$floating" = "false" ]; then
    hyprctl dispatch togglefloating
fi

hyprctl dispatch pin

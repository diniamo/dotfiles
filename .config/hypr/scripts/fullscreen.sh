#!/bin/sh

if [ "$#" -lt 1 ]; then
    echo "No fullscreen mode specified. Exiting."
    exit 1
fi

WORKSPACE_ID=$(hyprctl -j activeworkspace | jq -r '.id')

if hyprctl -j activeworkspace | jq -e '.hasfullscreen' >/dev/null; then
    HYPRLAND_CONF=$(cat "$HOME/.config/hypr/hyprland.conf")
    GAPS_OUT=$(printf '%s' "$HYPRLAND_CONF" | grep -oP '(gaps_out\s*=\s*)\K(\d*)')
    ROUNDING=$(printf '%s' "$HYPRLAND_CONF" | grep -oP '(rounding\s*=\s*)\K(\d*)')

    hyprctl keyword workspace "$WORKSPACE_ID, gapsout:$GAPS_OUT,border:true,rounding:$ROUNDING"
    hyprctl dispatch fullscreen
else
    hyprctl keyword workspace "$WORKSPACE_ID, gapsout:0,border:false,rounding:0"
    hyprctl dispatch fullscreen "$1"
fi

#!/bin/sh

WORKSPACE_ID=$(hyprctl -j activeworkspace | jq -r '.id')
if hyprctl -j activeworkspace | jq -e '.hasfullscreen' >/dev/null; then
    HYPRLAND_CONF=$(cat "$HOME/.config/hypr/hyprland.conf")
    GAPS_OUT=$(printf '%s' "$HYPRLAND_CONF" | grep -oP '(gaps_out\s*=\s*)\K(\d*)')
    ROUNDING=$(printf '%s' "$HYPRLAND_CONF" | grep -oP '(rounding\s*=\s*)\K(\d*)')

    hyprctl keyword workspace "$WORKSPACE_ID, gapsout:$GAPS_OUT,border:true,rounding:$ROUNDING"
else
    hyprctl keyword workspace "$WORKSPACE_ID, gapsout:0,border:false,rounding:0"
fi
hyprctl dispatch fullscreen 1

#!/bin/sh
# This is needed because turning the main laptop screen on crashes waybar for some reason

while true; do
    waybar >/dev/null 2>&1
done

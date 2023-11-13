#!/bin/sh

while hyprctl -j instances | jq -e 'length != 0'; do
    waybar
done

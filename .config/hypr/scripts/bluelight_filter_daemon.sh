#!/bin/bash
# This script currently requires autoreload to be off, otherwise there will be issues
# Should be run with exec, and not exec-once

for pid in $(pgrep -f $0); do
    if [ $pid != $$ ]; then
        kill $pid
    fi 
done

SHADER_FILE="$HOME/.config/hypr/shaders/blue-light-filter.glsl"

start_interp=1200
end_interp=1320

end=300

min_temp=2600
max_temp=4000

while true; do
    hour=$(date +%T | cut -f1 -d':')
    minute=$(date +%T | cut -f2 -d':')
    minutes=$((hour*60 + minute))

    # 05:00 - 20:00
    if ((minutes >= end && minutes < start_interp)); then
        hyprctl keyword decoration:screen_shader "[[EMPTY]]"
    else
        # 20:00 - 22:00
        if ((minutes >= start_interp && minutes <= end_interp)); then
            temperature="$(( max_temp+(minutes-start_interp)*(min_temp-max_temp)/(end_interp-start_interp) )).0"
        else
            temperature="$min_temp.0"
        fi

        if [[ "$temperature" != "$last_temp" ]]; then
            sed -E -i "s/temperature = ([0-9]{4})\.[0-9]/temperature = $temperature/" "$SHADER_FILE"
            # sleep 0.1
            hyprctl keyword decoration:screen_shader "$SHADER_FILE"

            last_temp="$temperature"
        fi
    fi

    sleep 10m
done

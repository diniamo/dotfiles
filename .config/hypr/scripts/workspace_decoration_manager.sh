#!/bin/sh

state_file="/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/fullscreen_state.json"

workspace_id=$(hyprctl -j activeworkspace | jq -r '.id')
workspace_string=$(hyprctl -j activeworkspace | jq -r '.name')
if [ "$workspace_string" != "$workspace_id" ]; then
    workspace_string="name:$workspace_string"
fi


get_option() {
    if [ -z "$4" ]; then
        name="$workspace_string"
    else
        name="$4"
    fi

    if [ ! -z "$1" ]; then
        value=$(hyprctl -j workspacerules | jq -r ".[] | select(.workspaceString == \"$name\") | .$1")
    fi

    if [ "$value" = "null" -o -z "$value" ]; then
        value=$(hyprctl -j getoption "$2" | jq -r ".$3")
    fi

    printf '%s' "$value"
}

get_state_option() {
    value=$(printf '%s' "$state" | jq -r ".\"$workspace_string\".$1")

    if [ "$value" = "null" ]; then
        value=$(get_option '' "$2" "$3")
    fi

    printf '%s' "$value"
}

case "$1" in
    init)
        state=$(hyprctl workspaces -j | jq -r '.[] | select(.name | startswith("special:") | not) | .name' | while read -r name; do
            printf '%s' "$current_state\"$name\": {
    \"gapsout\": $(get_option 'gapsOut' 'general:gaps_out' 'int' "$name"),
    \"rounding\": $(get_option 'rounding' 'decoration:rounding' 'int' "$name"),
    \"border\": $(get_option 'border' 'general:border_size' 'int' "$name")
}"
        done)
        state=$(printf '%s' "$state" | sed 's/}"/},"/')

        echo "blah"
        echo "$state"
        
        printf '{\n%s}' "$state" > "$state_file"
    ;;
    on)
        state=$(cat "$state_file")
        hyprctl keyword workspace "$workspace_id, gapsout:$(get_state_option 'gapsout' 'general:gaps_out' 'int'),border:$(get_state_option 'border' 'general:border_size' 'int'),rounding:$(get_state_option 'rounding' 'decoration:rounding' 'int')"
    ;;
    off)
        hyprctl keyword workspace "$workspace_id, gapsout:0,border:false,rounding:false"
    ;;
esac

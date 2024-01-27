#!/bin/sh

state_file="/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/fullscreen_state.json"

workspace_id=$(hyprctl -j activeworkspace | jq -r '.id')
workspace_string=$(hyprctl -j activeworkspace | jq -r '.name')
if [ "$workspace_string" != "$workspace_id" ]; then
    workspace_string="name:$workspace_string"
fi

# Arguments: workspaceString, workspaceRule, [defaultValue] OR [option, type]
get_option() {
    if [ -n "$1" ]; then
        value=$(hyprctl -j workspacerules | jq -r ".[] | select(.workspaceString == \"$1\") | .$2")
    fi

    if [ "$value" = "null" -o -z "$value" ]; then
        case "$#" in
            3) value="$3" ;;
            4) value="$(hyprctl -j getoption "$3" | jq -r ".$4")" ;;
        esac
    fi

    printf '%s' "$value"
}

get_state_option() {
    value=$(printf '%s' "$state" | jq -r ".\"$workspace_string\".$1")
    printf '%s' "$value"
}

case "$1" in
    init)
        default_monitor="$(hyprctl -j monitors | jq -r 'first | .name')"
        state=$(hyprctl -j workspacerules | jq -r '.[] | .workspaceString' | while read -r name; do
            printf '%s' "\"$name\": {
    \"gapsout\": $(get_option "$name" 'gapsOut' 'general:gaps_out' 'int'),
    \"rounding\": $(get_option "$name" 'rounding' 'decoration:rounding' 'int'),
    \"border\": $(get_option "$name" 'border' 'general:border_size' 'int'),
    \"gapsin\": $(get_option "$name" 'gapsIn' 'general:gaps_in' 'int'),
    \"monitor\": \"$(get_option "$name" 'monitor' "$default_monitor")\"
}"
        done)
        state=$(printf '%s' "$state" | sed 's/}"/},"/')
        printf '{\n%s}' "$state" > "$state_file"
    ;;
    on)
        state="$(cat "$state_file")"
        hyprctl keyword workspace "$workspace_id, gapsin:$(get_state_option 'gapsin'),gapsout:$(get_state_option 'gapsout'),border:$(get_state_option 'border'),rounding:$(get_state_option 'rounding'),monitor:$(get_state_option 'monitor')"
    ;;
    off)
        hyprctl keyword workspace "$workspace_id, gapsout:0,border:false,rounding:false"
    ;;
esac

#!/bin/sh

if hyprctl -j monitors | jq -e 'any(.[]; .specialWorkspace.name != "")'; then
    exit 0
fi


workspace_id=$(hyprctl -j activeworkspace | jq -r '.id')
workspace_string=$(hyprctl -j activeworkspace | jq -r '.name')
if [ "$workspace_string" != "$workspace_id" ]; then
    workspace_string="name:$workspace_string"
fi

state_file="/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/fullscreen_state.json"
if [ ! -f "$state_file" ]; then
    printf '{}' > "$state_file"

    original_state='{}'
else
    original_state=$(cat "$state_file")
fi


get_option() {
    if [ ! -z "$1" ]; then
        value=$(hyprctl -j workspacerules | jq -r ".[] | select(.workspaceString == \"$workspace_string\") | .$1")
    fi

    if [ "$value" = "null" -o -z "$value" ]; then
        value=$(hyprctl -j getoption "$2" | jq -r ".$3")
    fi

    printf '%s' "$value"
}

get_state_option() {
    value=$(printf '%s' "$original_state" | jq -r ".\"$workspace_id\".$1")

    if [ "$value" = "null" ]; then
        echo "$1 does not exist in the state file!" 1>&2
        exit 1
    fi

    printf '%s' "$value"
}

if hyprctl -j activeworkspace | jq -e '.hasfullscreen' >/dev/null; then
    hyprctl keyword workspace "$workspace_id, gapsout:$(get_state_option 'gapsout'),border:$(get_state_option 'border'),rounding:$(get_state_option 'rounding')"
    hyprctl dispatch fullscreen
else
    gaps_out=$(get_option 'gapsOut' 'general:gaps_out' 'int')
    rounding=$(get_option 'rounding' 'decoration:rounding' 'int')
    border=$(get_option 'border' 'general:border_size' 'int')

    printf 'gaps_out: "%s"\nborder: "%s"\nrounding: "%s"\n' "$gaps_out" "$border" "$rounding"

    tmp=$(mktemp)
    printf '%s' "$original_state" | jq ".\"$workspace_id\".gapsout = \"$gaps_out\" | .\"$workspace_id\".rounding = \"$rounding\" | .\"$workspace_id\".border = \"$border\"" > "$tmp"
    mv "$tmp" "$state_file"

    hyprctl keyword workspace "$workspace_id, gapsout:0,border:false,rounding:false"
    hyprctl dispatch fullscreen 1
fi

#!/bin/sh

choose_interface() {
    interfaces=$(ip link show | grep -oP '(?<=: ).*(?=:.*state UP)')
    case "$(printf "%s" "$interfaces" | wc -w)" in
        0)
            echo "There are no active interfaces!"
            exit 1
            ;;
        1) interface="$interfaces" ;;
        *) interface="$(printf "%s" "$interfaces" | fzf --reverse --prompt "Choose an interface: ")" ;;
    esac
}

case "$1" in
    send)
        choose_interface
        echo "Using interface $interface"

        shift
        qrcp send --interface "$interface" "$@"
    ;;
    receive)
        choose_interface
        echo "Using interface $interface"

        qrcp receive --interface "$interface"
    ;;
    *)
        echo "$1 isn't a qrcp action!"
        exit 1
    ;;
esac

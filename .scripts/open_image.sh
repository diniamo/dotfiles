#!/bin/sh

case "$(wl-paste --list-types)" in
    *text*)
        notify-send 'Opening image URL'
        curl -sL "$(wl-paste)" | imv -
        ;;
    *image*)
        notify-send 'Opening image'
        wl-paste | imv -
        ;;
    *)
        notify-send 'Failed to open image'
        ;;
esac

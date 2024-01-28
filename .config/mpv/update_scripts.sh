#!/usr/bin/bash

scripts=(
    "https://raw.githubusercontent.com/4e6/mpv-reload/master/reload.lua"
    "https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.lua"
    "https://github.com/hoyon/mpv-mpris/releases/latest/download/mpris.so"
    # "https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua"
    "https://raw.githubusercontent.com/Eisa01/mpv-scripts/master/scripts/UndoRedo.lua"
    # "https://raw.githubusercontent.com/diniamo/mpv-scripts/master/fullscreen.lua"
    "https://raw.githubusercontent.com/diniamo/mpv-scripts/master/skip-intro.lua"
    "https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua"
    "https://raw.githubusercontent.com/dexeonify/mpv-config/main/scripts/seek-to.lua"
    "https://raw.githubusercontent.com/diniamo/mpv-scripts/master/clipshot.lua"
)

mpv_dir="${XDG_CONFIG_HOME:-$HOME/.config}/mpv"
scripts_dir="$mpv_dir/scripts"

rm -rfv "$scripts_dir" "$mpv_dir/fonts"
mkdir -v "$scripts_dir"

for script in "${scripts[@]}"; do
    wget --directory-prefix "$scripts_dir" "$script"
done

# autosubsync-mpv
git clone "https://github.com/Ajatt-Tools/autosubsync-mpv" "$scripts_dir/autosubsync"

# sponsorblock
git clone -- "https://www.github.com/po5/mpv_sponsorblock" "/tmp/mpv_sponsorblock"
mv -v "/tmp/mpv_sponsorblock/sponsorblock.lua" "/tmp/mpv_sponsorblock/sponsorblock_shared/" "$scripts_dir"
rm -rfv /tmp/mpv_sponsorblock/

# uosc
wget -P /tmp/ https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip
unzip -od "$mpv_dir" /tmp/uosc.zip
rm -fv /tmp/uosc.zip

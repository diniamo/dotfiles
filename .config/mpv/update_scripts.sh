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
)

mpv_dir="${XDG_CONFIG_HOME:-$HOME/.config}/mpv"
tmp_dir="/tmp"

rm -rfv "$mpv_dir/scripts" "$mpv_dir/fonts"
mkdir -v "$mpv_dir/scripts"

for script in "${scripts[@]}"; do
    wget --directory-prefix "$mpv_dir/scripts/" "$script"
done

# mpv-cut
# git clone -b release --single-branch "https://github.com/familyfriendlymikey/mpv-cut.git" "$mpv_dir/scripts/mpv-cut"

# sponsorblock
git clone -- "https://www.github.com/po5/mpv_sponsorblock" "/tmp/mpv_sponsorblock"
mv -v "/tmp/mpv_sponsorblock/sponsorblock.lua" "/tmp/mpv_sponsorblock/sponsorblock_shared/" "$mpv_dir/scripts/"
rm -rfv /tmp/mpv_sponsorblock/

# uosc
wget -P /tmp/ https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip
unzip -od "$mpv" /tmp/uosc.zip
rm -fv /tmp/uosc.zip

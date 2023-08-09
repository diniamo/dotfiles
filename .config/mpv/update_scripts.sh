scripts=(
    "https://raw.githubusercontent.com/4e6/mpv-reload/master/reload.lua"
    "https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.lua"
    "https://github.com/hoyon/mpv-mpris/releases/latest/download/mpris.so"
    "https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua"
    "https://raw.githubusercontent.com/Eisa01/mpv-scripts/master/scripts/UndoRedo.lua"
)

mpv_dir="${XDG_CONFIG_HOME:-$HOME/.config}/mpv"
tmp_dir="/tmp"

rm  -rfv "$mpv_dir/scripts" "$mpv_dir/script-opts" "$mpv_dir/fonts"
mkdir -v "$mpv_dir/scripts" "$mpv_dir/script-opts"

for script in "${scripts[@]}"; do
    wget --directory-prefix "$mpv_dir/scripts/" "$script"
done

# sponsorblock
git clone -- "https://www.github.com/po5/mpv_sponsorblock" "/tmp/mpv_sponsorblock"
mv -v "/tmp/mpv_sponsorblock/sponsorblock.lua" "/tmp/mpv_sponsorblock/sponsorblock_shared/" "$mpv_dir/scripts/"
rm -rfv /tmp/mpv_sponsorblock/

# uosc
wget -P /tmp/ https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip
unzip -od "$mpv" /tmp/uosc.zip
rm -fv /tmp/uosc.zip

scripts=(
    "4e6/mpv-reload:reload.lua"
    "po5/mpv_sponsorblock:sponsorblock.lua,sponsorblock_shared"
    "po5/thumbfast:thumbfast.lua"
)

mpv_dir="${XDG_CONFIG_HOME:-$HOME/.config}/mpv"
tmp_dir="/tmp"

rm  -rfv "$mpv_dir/scripts" "$mpv_dir/script-opts" "$mpv_dir/fonts"
mkdir -v "$mpv_dir/scripts" "$mpv_dir/script-opts"

for script in "${scripts[@]}"; do
    split=($(printf "%s" "$script" | sed "s/:/ /"))
    # printf "%s\n" "$split"
    # printf "%s " "${split[1]}"
    # printf "%s\n\n" "${split[2]}"
    contents=($(printf "%s" ${split[1]} | sed "s/,/ /g"))

    split=($(printf "%s" $split | sed "s/\// /"))
    user="$split"
    repo="${split[1]}"

    # printf "%s\n%s\n%s\n\n\n" "$user" "$repo" "$contents"

    git clone -- "https://www.github.com/$user/$repo.git" "/tmp/$repo"
    for content in "${contents[@]}"; do
        mv -v "/tmp/$repo/$content" "$mpv_dir/scripts" 
    done
    rm -rfv "/tmp/$repo"
done

# we do uosc separately because it uses a different structure
wget -P /tmp/ https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip
unzip -od "$mpv" /tmp/uosc.zip
rm -fv /tmp/uosc.zip

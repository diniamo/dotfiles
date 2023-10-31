#!/bin/sh

# Converts qBittorrent shared storage between POSIX and Windows savepaths

# Evert Mouw, 2021-03

# change savepaths for .fastresume files used by qBittorrent
# handy when switching between Windows and Linux (posix paths)
# while using the same qBittorrent download folder and BT_backup folder
# dependency: https://github.com/tool-maker/bencode-pretty
# also see the systemd unit below

# argument 1: { windows || posix }

# These constants should be set in a configuration file or set
# as an argument, but currenty this is just for personal use.
BT_backup="/torrent/BT_backup"
sed_toPos='s/E:[\/\\]complete/\/torrent\/complete/g'
sed_toWin='s/\/torrent\/complete/E:\\complete/g'

case $1 in
  windows) SED_STRING="$sed_toWin" ;;
  posix)   SED_STRING="$sed_toPos" ;;
  *)
    echo "No valid first argument."
    exit 1
    ;;
esac

cd "$BT_backup"
for FILE in *.fastresume
do
    cat $FILE | bencode_pretty | sed "$SED_STRING" | bencode_unpretty > $1.tmp
    cp $1.tmp $FILE
    rm $1.tmp
done

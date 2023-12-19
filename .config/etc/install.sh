#!/bin/sh

# $(dirname $(readlink -f "$0"))
sudo find $(dirname "$0") -type f -not -name "install.sh" -exec cp -f $(dirname $(readlink -f "$0"))/{} /etc/{} \;

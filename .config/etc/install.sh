# $(dirname $(readlink -f "$0"))
sudo find $(dirname "$0") -type f -not -name "install.sh" -exec ln -sf $(dirname $(readlink -f "$0"))/{} /etc/{} \;
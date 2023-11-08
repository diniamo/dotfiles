if ! command -v sudo > /dev/null; then
	echo "Please set sudo up before running this script!"
	exit
fi

ROOT=$(dirname "$0")
echo "Script directory: $ROOT"

if ! grep -qxF "[chaotic-aur]" /etc/pacman.conf; then
	echo "Adding chaotic-aur..."
	pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
	pacman-key --lsign-key 3056513887B78AEB
	sudo pacman -U --noconfirm "https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst" "https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst"
	echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf
fi


echo "Installing packages..."
sudo pacman -Sy --needed --noconfirm yay
yay -Y --devel --save
yay -S --needed - < $ROOT/packages.txt

echo "Enabling services..."
sudo systemctl enable ly

if [ !  -d "$HOME/.dotfiles" ]; then
	echo "Initializing dotfiles..."
	echo ".dotfiles" >> $HOME/.gitignore
	if git clone --recurse-submodules --bare git@github.com:diniamo/dotfiles.git $HOME/.dotfiles; then
		git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" checkout --force
		git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" config --local status.showUntrackedFiles no

        git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
        git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
        exec zsh

        bat cache --build

        $HOME/.config/mpv/update_scripts.sh
	else
		echo "Please run the script again once you have set an ssh key up!"
	fi
fi



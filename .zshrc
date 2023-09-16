# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
	git
	git-escape-magic
	colored-man-pages
	# command-not-found
	gitignore
	sudo
	copypath
	copyfile
	fancy-ctrl-z
	dircycle
	alias-finder
	safe-paste
)

custom_plugins=(
	MichaelAquilina/zsh-you-should-use
	MichaelAquilina/zsh-auto-notify:auto-notify
	zsh-users/zsh-autosuggestions
	zsh-users/zsh-syntax-highlighting
	agkozak/zsh-z
	hlissner/zsh-autopair
	joshskidmore/zsh-fzf-history-search
	zpm-zsh/colorize
)
autoload -U add-zsh-hook
source $HOME/.zsh_plugins > /dev/null 2>&1

# OMZ
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh

autopair-init

# Options/settings
setopt EXTENDEDGLOB
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt autocd
setopt correct

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=true

TUI=("jerry" "lobster" "nmtui" "ncspot" "pulsemixer" "ranger")

# remove-padding() {
# 	local IFS=' '
# 	local cmd=($=1)
# 	cmd=$cmd[1]
# 	if (($TUI[(Ie)$cmd])); then
# 		kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0
# 	fi
# }
# readd-padding() {
# 	local lastcmd=$(fc -ln -1)
# 	local IFS=' '
# 	lastcmd=($=lastcmd)
# 	lastcmd=$lastcmd[1]
# 	if (($TUI[(Ie)$lastcmd])); then
# 		kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=5
# 	fi
# }
# add-zsh-hook preexec remove-padding
# add-zsh-hook precmd readd-padding

AUTO_NOTIFY_IGNORE+=("feh" "scrcpy" "bg" "fg" "mpv" "locedit" "bluetoothctl" "btop" "bacon")
AUTO_NOTIFY_IGNORE+=($TUI)

bindkey "^[[1;5D" insert-cycledleft
bindkey "^[[1;5C" insert-cycledright

bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# Environment variables
source $HOME/.zshenv
# Aliases
source $HOME/.zsh_aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

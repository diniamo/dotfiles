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
	command-not-found
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
source $HOME/.zsh_plugins > /dev/null 2>&1


# OMZ
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh

autopair-init

# Options/settings
setopt EXTENDEDGLOB
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=true

AUTO_NOTIFY_IGNORE+=("feh" "jerry" "nmtui" "scrcpy" "bg" "fg")

bindkey "^[[104;6u" insert-cycledleft
bindkey "^[[108;6u" insert-cycledright

# Aliases
source $HOME/.zsh_aliases

# Pure theme
# fpath+=($HOME/.zsh/pure)
# autoload -U promptinit && promptinit
# prompt pure

# Starship
# eval "$(starship init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

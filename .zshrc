export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

# Custom
( source $HOME/.zsh_plugins & ) > /dev/null 2>&1
source $HOME/.zsh_aliases

plugins=( git ripgrep colored-man-pages command-not-found dotenv gitignore sudo
	zsh-autocomplete
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-you-should-use
	zsh-z 
)

# OMZ
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh

# Plugin settings
ZSH_AUTOSUGGEST_STRATEGY=(history)

zstyle ':completion:*:warnings' format
bindkey -M menuselect '\r' .accept-line
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# Pure theme
# fpath+=($HOME/.zsh/pure)
# autoload -U promptinit && promptinit
# prompt pure

# Starship
eval "$(starship init zsh)"

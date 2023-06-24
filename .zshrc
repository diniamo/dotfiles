export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

( source $HOME/.zsh_plugins & ) > /dev/null 2>&1

plugins=( git ripgrep colored-man-pages command-not-found dotenv gitignore sudo
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-you-should-use
	zsh-z 
)

# Plugin settings
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh

source $HOME/.zsh_aliases

# Pure theme
fpath+=($HOME/.zsh/pure)
autoload -U promptinit && promptinit
prompt pure

# Starship
# eval "$(starship init zsh)"

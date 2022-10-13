export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=( git zsh-z ripgrep colored-man-pages command-not-found dotenv gitignore sudo

	zsh-autosuggestions
	zsh-syntax-highlighting
)

# Plugin settings
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/.local/bin"

source $HOME/.zsh_aliases

# Pure theme
fpath+=($HOME/.zsh/pure)
autoload -U promptinit && promptinit
prompt pure

# Starship
# eval "$(starship init zsh)"

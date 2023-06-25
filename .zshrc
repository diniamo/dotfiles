# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# Custom
source $HOME/.zsh_plugins > /dev/null 2>&1

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=( git ripgrep colored-man-pages command-not-found dotenv gitignore sudo
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-you-should-use
	zsh-z 
	zsh-autopair
	dircycle
)


# OMZ
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh

# Plugin settings
ZSH_AUTOSUGGEST_STRATEGY=(history)

autopair-init

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

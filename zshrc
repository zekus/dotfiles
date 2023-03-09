# Enable Powerlevel10k instant prompt. Should stay close to the top of zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.zsh/env
source $HOME/.zsh/prompt
source $HOME/.zsh/settings
source $HOME/.zsh/fzf
source $HOME/.zsh/style
source $HOME/.zsh/plugins
source $HOME/.zsh/langs
source $HOME/.zsh/functions
source $HOME/.zsh/aliases
source $HOME/zsh/aliases

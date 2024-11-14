# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.zsh/env
source $HOME/.zsh/settings
source $HOME/.zsh/langs
source $HOME/.zsh/functions
source $HOME/.zsh/aliases
source $HOME/zsh/aliases

## Z-Shell initialization https://wiki.zshell.dev/
source <(curl -sL init.zshell.dev); zzinit

# powerlevel10k
zi ice depth'1' atload"[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" nocd
zi light romkatv/Powerlevel10k

# Oh-My_Zsh https://wiki.zshell.dev/docs/getting_started/migration
zi is-snippet wait lucid for \
    atload"unalias grv g" \
  OMZP::{git,sudo,encode64,extract,asdf} \
    if'[[ -d ~/.nvm ]]' \
  OMZP::nvm \
    if'[[ -d ~/.ssh ]]' \
  OMZP::ssh-agent \
    if'[[ -d ~/.gnupg ]]' \
  OMZP::gpg-agent \
    if'[[ "$OSTYPE" = *-gnu ]]' \
  OMZP::gnu-utils

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

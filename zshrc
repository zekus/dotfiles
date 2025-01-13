source $HOME/.zsh/env
source $HOME/.zsh/settings
source $HOME/.zsh/langs
source $HOME/.zsh/functions
source $HOME/.zsh/aliases
source $HOME/zsh/aliases

## Z-Shell initialization https://wiki.zshell.dev/
source <(curl -sL init.zshell.dev); zzinit

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

# Added by Windsurf
export PATH="/Users/antoniolorusso/.codeium/windsurf/bin:$PATH"

eval "$(starship init zsh)" 

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/antoniolorusso/.cache/lm-studio/bin"

typeset -A ZI
ZI[BIN_DIR]="${HOME}/.zi/bin"
source "${ZI[BIN_DIR]}/zi.zsh"

source $HOME/.zsh/env
source $HOME/.zsh/settings
source $HOME/.zsh/langs
source $HOME/.zsh/functions
source $HOME/.zsh/aliases
source $HOME/zsh/aliases

# Oh-My_Zsh https://wiki.zshell.dev
zi is-snippet wait lucid for \
    atload"unalias grv g" \
  OMZP::{git,sudo,encode64,extract,yarn} \
    if'[[ -d ~/.nvm ]]' \
  OMZP::nvm \
    if'[[ -d ~/.ssh ]]' \
  OMZP::ssh-agent \
    if'[[ -d ~/.gnupg ]]' \
  OMZP::gpg-agent \
    if'[[ "$OSTYPE" = *-gnu ]]' \
  OMZP::gnu-utils

source /opt/homebrew/opt/asdf/libexec/asdf.sh

# asdf configuration
export PATH="$ASDF_DATA_DIR/shims:$PATH"    
fpath=(/opt/homebrew/opt/asdf/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Added by Windsurf
export PATH="/Users/antoniolorusso/.codeium/windsurf/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/antoniolorusso/.cache/lm-studio/bin"

# uv local tools
export PATH="/Users/antoniolorusso/.local/bin:$PATH"

eval "$(starship init zsh)" 

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Added by Antigravity
export PATH="/Users/antoniolorusso/.antigravity/antigravity/bin:$PATH"

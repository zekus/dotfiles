## custom paths
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# fix the locale
export LC_ALL=en_US.UTF-8

# iterm2 integration
#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source <(antibody init)

ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
antibody bundle robbyrussell/oh-my-zsh
antibody bundle robbyrussell/oh-my-zsh folder:plugins/common-aliases
antibody bundle "
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions

  robbyrussell/oh-my-zsh path:plugins/git
  robbyrussell/oh-my-zsh path:plugins/gitfast
  robbyrussell/oh-my-zsh path:plugins/git-extras
  robbyrussell/oh-my-zsh path:plugins/gpg-agent
  robbyrussell/oh-my-zsh path:plugins/docker
  robbyrussell/oh-my-zsh path:plugins/brew
  robbyrussell/oh-my-zsh path:plugins/gem
  robbyrussell/oh-my-zsh path:plugins/osx
  robbyrussell/oh-my-zsh path:plugins/mix
  robbyrussell/oh-my-zsh path:plugins/kubectl

  romkatv/powerlevel10k
"

# Never know when you're gonna need to popd!
setopt AUTO_PUSHD

# Allow completing of the remainder of a command
bindkey "^N" insert-last-word

# Save a ton of history
HISTSIZE=20000
HISTFILE=$HOME/.zsh_history
SAVEHIST=20000

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

fpath=($HOME/.dotfiles/zsh/completions /usr/local/share/zsh/site-functions $fpath)

# Base16-shell via base16-manager
BASE16_SHELL="$HOME/.base16-manager/chriskempson/base16-shell/"
[ -n "$PS1" ] && [ ! -v VIM ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL/profile_helper.sh")"

# Source my custom files after oh-my-zsh so I can override things.
source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions

# machine specific aliases (not on git)
source $HOME/zsh/aliases

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# FZF autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export GREP_OPTIONS="--exclude-dir=.svn --exclude-dir=.git --color"
export EDITOR=vim

# Ruby
export RUBY_GC_MALLOC_LIMIT=90000000
export RUBY_GC_HEAP_FREE_SLOTS=200000

# Elixir/Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

# Universal runtime manager
source $(brew --prefix asdf)/asdf.sh

# Execute a command at every directory change
chpwd() {
  # Show contents of directory after cd-ing into it
  # ls -lrthG
  # source custom aliases for the directory
  custom_aliases
}

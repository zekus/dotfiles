#!/bin/zsh
set -e

DOTFILES_DIR="$HOME/.dotfiles"
cd "$DOTFILES_DIR"

echo "Linking dotfiles with stow..."

# Stow packages for dotfiles
PACKAGES=(
    "shell"      # Shell config (.zshrc, .asdfrc, etc.)
    "git"        # Git config
    "ruby"       # Ruby tools
    "tools"      # CLI tools, Brewfile
)

# These directories are symlinked directly (not via stow)
# Create them if they don't exist
echo "  Linking directory packages..."
[[ ! -L "$HOME/.config" ]] && ln -sf "$DOTFILES_DIR/config" "$HOME/.config"
[[ ! -L "$HOME/.zsh" ]] && ln -sf "$DOTFILES_DIR/zsh" "$HOME/.zsh"
[[ ! -L "$HOME/.vscode" ]] && ln -sf "$DOTFILES_DIR/vscode" "$HOME/.vscode"

for pkg in "${PACKAGES[@]}"; do
    if [[ -d "$pkg" ]]; then
        echo "  Stowing $pkg..."
        stow --restow "$pkg"
    fi
done

# Note: SSH is managed via Keybase, not stowed
# ln -sf /Volumes/Keybase/private/lantonio/ssh ~/.ssh

echo "Done! All packages stowed."
cd -

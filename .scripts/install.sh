#!/usr/bin/env bash

DPATH=$HOME/.dotfiles

function main() {

  echo
  read -p "Install software? Y/N" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    software
  fi

  echo
  read -p "Install langs? Y/N" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    langs
  fi

  echo
  echo "+-------------------------------+"
  echo "|        Linking Configs        |"
  echo "+-------------------------------+"
  echo

  # Ensure stow is available (installed via Brewfile)
  if ! command -v stow &>/dev/null; then
    echo "Error: stow is required. Please run with 'Install software? Y' first."
    exit 1
  fi

  $DPATH/.scripts/linkconfigs.sh

}

function langs() {
  echo
  echo "+------------------------------------------+"
  echo "|   Installing Languages from tool-versions   |"
  echo "+------------------------------------------+"
  echo

  # Ensure mise is available (installed via Brewfile)
  if ! command -v mise &>/dev/null; then
    echo "Error: mise is required. Please run with 'Install software? Y' first."
    exit 1
  fi

  # Trust the dotfiles directory
  mise trust "$HOME/.dotfiles"

  # Install all versions defined in ~/.tool-versions
  echo "Installing versions from tool-versions..."
  mise install

  # Install language-specific tools
  echo
  echo "Installing Elixir language server..."
  mix escript.install hex elixir_ls --force

  echo
  echo "Languages installed successfully!"
}

function software() {

  touch $HOME/.bash_profile

  echo
  echo "+-----------------------------------+"
  echo "|        Installing Homebrew        |"
  echo "+-----------------------------------+"
  echo
  xcode-select --install
  # [ m1 ] insure required dir in path
  export PATH=/opt/homebrew/bin:$PATH
  is_arm64() {
    test "$(uname -m)" = "arm64"
  }
  if is_arm64; then
    local homebrew_bin="/opt/homebrew/bin"
    if ! cat /etc/paths | grep -q "${homebrew_bin}"; then
      echo "setting up homebrew binary path for gui apps"
      echo -e "${homebrew_bin}\n$(cat /etc/paths)" | sudo tee /etc/paths >/dev/null
    fi
  fi

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo
  echo "+-----------------------------------+"
  echo "|        Installing Software        |"
  echo "+-----------------------------------+"
  echo

  # Note: mise is installed via Brewfile

  # Install packages from Brewfile (located in tools package)
  brew bundle install --file $DPATH/tools/.Brewfile

  echo
  echo "+---------------------------------+"
  echo "|          Installing Zi          |"
  echo "+---------------------------------+"
  echo
  if [ ! -d "$HOME/.zi" ]; then
    git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" &&
      echo "Zi installation successful." ||
      echo "Zi clone failed."
  fi

}

main

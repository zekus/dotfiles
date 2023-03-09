#!/bin/zsh
cd $HOME/.dotfiles

/bin/ls -d */ | xargs -n1 stow

cp -f .other/fonts/* $HOME/Library/Fonts/

cd -

#!/bin/bash
echo "Setting up dotfiles..."

DOTFILES_DIR=~/dotfiles

# Create symlinks for all dotfiles
ln -sf $DOTFILES_DIR/bash_profile ~/.bash_profile
ln -sf $DOTFILES_DIR/bashrc ~/.bashrc
ln -sf $DOTFILES_DIR/gitconfig ~/.gitconfig
ln -sf $DOTFILES_DIR/tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/zshrc ~/.zshrc

echo "Dotfiles have been set up!"


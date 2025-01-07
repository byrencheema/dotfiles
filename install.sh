#!/bin/bash

echo "Setting up dotfiles..."

DOTFILES_DIR=~/dotfiles

# Install Neovim
if ! command -v nvim &> /dev/null; then
    echo "Installing Neovim..."
    if [ "$(uname)" == "Darwin" ]; then
        brew install neovim
    elif [ "$(uname)" == "Linux" ]; then
        sudo apt update && sudo apt install -y neovim
    fi
else
    echo "Neovim already installed."
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh already installed."
fi

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo "Powerlevel10k theme already installed."
fi

# Set Powerlevel10k as default Zsh theme
if ! grep -q 'ZSH_THEME="powerlevel10k/powerlevel10k"' ~/.zshrc; then
    echo 'Setting Zsh theme to Powerlevel10k...'
    sed -i.bak 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
fi

# Create Neovim config directory and link vimrc
mkdir -p ~/.config/nvim
ln -sf $DOTFILES_DIR/vimrc ~/.config/nvim/init.vim

# Create symlinks for all dotfiles
ln -sf $DOTFILES_DIR/bash_profile ~/.bash_profile
ln -sf $DOTFILES_DIR/bashrc ~/.bashrc
ln -sf $DOTFILES_DIR/gitconfig ~/.gitconfig
ln -sf $DOTFILES_DIR/tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/zshrc ~/.zshrc

# Source Zsh configuration to apply changes
source ~/.zshrc

echo "Dotfiles have been set up with Neovim and Powerlevel10k!"


#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

echo "======================================"
echo "          Setting Up Dotfiles         "
echo "======================================"

# Define variables
DOTFILES_DIR=~/dotfiles
REPO_URL="https://github.com/yourusername/your-dotfiles-repo.git"

# Check for required commands
for cmd in git curl zsh; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: $cmd is not installed. Please install it and rerun the script."
        exit 1
    fi
done

# Detect package manager
if command -v apt &> /dev/null; then
    PACKAGE_MANAGER="apt"
elif command -v yum &> /dev/null; then
    PACKAGE_MANAGER="yum"
elif command -v pacman &> /dev/null; then
    PACKAGE_MANAGER="pacman"
else
    echo "Unsupported package manager. Please install dependencies manually."
    exit 1
fi

# Function to install packages
install_package() {
    if [ "$PACKAGE_MANAGER" == "apt" ]; then
        sudo apt update
        sudo apt install -y "$1"
    elif [ "$PACKAGE_MANAGER" == "yum" ]; then
        sudo yum install -y "$1"
    elif [ "$PACKAGE_MANAGER" == "pacman" ]; then
        sudo pacman -Syu --noconfirm "$1"
    fi
}

# Install Neovim
if ! command -v nvim &> /dev/null; then
    echo "Installing Neovim..."
    install_package neovim
else
    echo "Neovim already installed."
fi

# Install Tmux
if ! command -v tmux &> /dev/null; then
    echo "Installing Tmux..."
    install_package tmux
else
    echo "Tmux already installed."
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh already installed."
fi

# Install Powerlevel10k theme
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
    echo "Powerlevel10k theme already installed."
fi

# Set Powerlevel10k as default Zsh theme
if ! grep -q 'ZSH_THEME="powerlevel10k/powerlevel10k"' ~/.zshrc; then
    echo 'Setting Zsh theme to Powerlevel10k...'
    sed -i.bak 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
fi

ln -sf "$DOTFILES_DIR/bash_profile" ~/.bash_profile
ln -sf "$DOTFILES_DIR/bashrc" ~/.bashrc
ln -sf "$DOTFILES_DIR/gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES_DIR/vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/zshrc" ~/.zshrc

# Create Neovim config directory and link init.vim
mkdir -p ~/.config/nvim
ln -sf "$DOTFILES_DIR/vimrc" ~/.config/nvim/init.vim

# Change default shell to zsh if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
fi

# Source Zsh configuration to apply changes
echo "Sourcing ~/.zshrc..."
source ~/.zshrc

echo "======================================"
echo "    Dotfiles setup complete! 🚀"
echo "======================================"
echo "Please restart your terminal or log out and back in for all changes to take effect."


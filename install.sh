#!/bin/bash

set -euo pipefail

echo "======================================"
echo "    Setting Up Fresh Dev Environment  "
echo "======================================"

DOTFILES_DIR="$HOME/dotfiles"

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: This script is designed for macOS only."
    exit 1
fi

# install homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed."
fi

# install packages from brewfile
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    echo "Installing packages from Brewfile..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
else
    echo "Warning: Brewfile not found. Skipping package installation."
fi

# create directories
echo "Creating config directories..."
mkdir -p ~/.config/helix
mkdir -p ~/.config/karabiner
mkdir -p ~/.config/ghostty

# symlink configs
echo "Creating symlinks..."

ln -sf "$DOTFILES_DIR/zshrc" ~/.zshrc

if [ -f "$DOTFILES_DIR/gitconfig" ]; then
    ln -sf "$DOTFILES_DIR/gitconfig" ~/.gitconfig
fi

if [ -f "$DOTFILES_DIR/tmux.conf" ]; then
    ln -sf "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf
fi

ln -sf "$DOTFILES_DIR/config/starship.toml" ~/.config/starship.toml
ln -sf "$DOTFILES_DIR/config/helix/config.toml" ~/.config/helix/config.toml
ln -sf "$DOTFILES_DIR/config/karabiner/karabiner.json" ~/.config/karabiner/karabiner.json
ln -sf "$DOTFILES_DIR/config/ghostty/config" ~/.config/ghostty/config

echo ""
echo "======================================"
echo "    Setup Complete! 🚀"
echo "======================================"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open Ghostty terminal"
echo "  3. Configure Git with your email:"
echo "     git config --global user.email 'your@email.com'"
echo ""

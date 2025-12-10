# dotfiles

my macos dev environment

## what i use

terminal: ghostty
theme: tokyo night
shell: zsh
prompt: starship
editor: helix
package manager: homebrew
key remapping: karabiner

## why these choices

ghostty - fast gpu-accelerated terminal, native macos app, good performance

tokyo night - consistent color scheme across all tools, easy on the eyes

zsh - default macos shell, good plugin ecosystem

starship - fast rust-based prompt, cross-platform, easy config, shows git status and language versions

helix - modal editor like vim but built-in lsp support, no plugin needed, modern defaults, multiple cursors

homebrew - standard macos package manager, everything i need is available

karabiner - powerful keyboard customization, caps lock as escape/control saves finger travel

## zsh plugins

zsh-autosuggestions - suggests commands as you type based on history
zsh-syntax-highlighting - highlights commands green/red for valid/invalid
fzf - fuzzy finder for history search and file finding

## key features

caps lock tap for escape, hold for control
starship shows git branch, status, and language context
helix has relative line numbers and bar cursor in insert mode
tmux prefix remapped to ctrl-a, uses | and - for splits

## install

clone this repo:
```
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

run install script:
```
./install.sh
```

restart terminal:
```
source ~/.zshrc
```

set git email:
```
git config --global user.email "your@email.com"
```

## what gets installed

the brewfile installs:
- helix, neovim, tmux, starship
- fzf, tree, hyperfine
- fnm (node version manager)
- uv (python package manager)
- awscli, sshuttle
- docker-desktop
- karabiner-elements
- fira code nerd font

## repo structure

```
dotfiles/
├── install.sh
├── Brewfile
├── zshrc
├── gitconfig
├── tmux.conf
└── config/
    ├── starship.toml
    ├── ghostty/config
    ├── helix/config.toml
    └── karabiner/karabiner.json
```

## aliases

navigation:
- .. (cd ..)
- ... (cd ../..)

files:
- l (ls -lah)
- ll (ls -lh)
- la (ls -lAh)

git:
- gst (git status)
- gaa (git add --all)
- gp (git push)
- gl (git pull)
- gb (git branch)
- glog (git log --oneline --decorate --graph)
- gsta (git stash)
- gstp (git stash pop)

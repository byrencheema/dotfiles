# dotfiles

my macos dev environment

## what i use

terminal: ghostty
theme: tokyo night
shell: zsh
prompt: powerlevel10k
editor: neovim (lazyvim)
package manager: homebrew
key remapping: karabiner

## why these choices

ghostty - fast gpu-accelerated terminal, native macos app, good performance

tokyo night - consistent color scheme across all tools, easy on the eyes

zsh - default macos shell, good plugin ecosystem

powerlevel10k - fast prompt with instant prompt support, shows git status and language versions

neovim + lazyvim - sane plugin defaults, built-in lsp, modal editing

homebrew - standard macos package manager, everything i need is available

karabiner - powerful keyboard customization, caps lock as escape/control saves finger travel

## zsh plugins

zsh-autosuggestions - suggests commands as you type based on history
zsh-syntax-highlighting - highlights commands green/red for valid/invalid
fzf - fuzzy finder for history search and file finding

## key features

caps lock tap for escape, hold for control
powerlevel10k shows git branch, status, and language context
tmux prefix remapped to ctrl-a, uses | and - for splits

## install

clone this repo:
```
git clone https://github.com/byrencheema/dotfiles.git ~/dotfiles
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

## secrets

api keys and anything machine-specific go in `~/.zshrc.local`, which is sourced at
the end of `zshrc` and is never committed:

```
export GEMINI_API_KEY="..."
```

## what gets installed

the brewfile installs:
- neovim, tmux, gh, htop
- fzf, tree
- uv (python package manager)
- node, yarn
- session-manager-plugin
- ghostty, rectangle
- docker-desktop
- karabiner-elements
- google sans code (terminal font)
- jetbrains mono nerd font (glyph icons only - google sans code has none)

## repo structure

```
dotfiles/
├── install.sh
├── Brewfile
├── zshrc
├── aliases
├── gitconfig
├── tmux.conf
└── config/
    ├── ghostty/config
    ├── karabiner/karabiner.json
    ├── corne/
    └── nvim/
```

## corne v4 keyboard

split keyboard running vial firmware. the keymap lives on the board itself, so it works on any
computer without vial installed. vial is only needed to edit it (or use vial.rocks in chrome).

base layer:
```
 esc  q  w  e  r  t [opt]        [ctl] y  u  i  o  p  bksp
 caps a  s  d  f  g [tab]        [sft] h  j  k  l  ;  '
 shft z  x  c  v  b                    n  m  ,  .  /  del
          fn  lower  space    enter  raise  cmd
```

- lower (hold): numbers on the top row, arrows on h j k l, f = ctrl+opt for rectangle
- raise (hold): symbols
- lower + raise (hold): f1-f12 on the top row (f11 on bksp, f12 on '), rgb on the left.
  the esc position is QK_BOOT, which reboots the board into flashing mode
- fn sends f18, and karabiner turns that into the mac fn/globe key
- caps is escape on tap and control on hold, via karabiner

karabiner ignores the corne by default because it reports as a keyboard and a mouse, so
`karabiner.json` has a device entry that turns it on.

back up or restore the keymap (close vial first):
```
cd ~/dotfiles/config/corne
uv run corne.py dump
uv run corne.py restore
```

## aliases

navigation:
- .. (cd ..)
- ... (cd ../..)
- mkcd (mkdir -p and cd into it)

files:
- l (ls -lah)
- ll (ls -lh)
- la (ls -lAh)

editor:
- vim (nvim)

ai agents:
- c (claude --dangerously-skip-permissions)
- cc (claude --dangerously-skip-permissions --continue)
- cx (codex --yolo)

git:
- gst (git status)
- gaa (git add --all)
- gp (git push)
- gl (git pull)
- gb (git branch)
- glog (git log --oneline --decorate --graph)
- gsta (git stash)
- gstp (git stash pop)

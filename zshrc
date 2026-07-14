# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ls aliases
alias ls='ls -G'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# Editor
alias vim='nvim'

# AI agents
alias c='claude --dangerously-skip-permissions'
alias cc='claude --dangerously-skip-permissions --continue'
alias cx='codex --yolo'

# Git aliases
alias gaa='git add --all'
alias gsta='git stash'
alias gstp='git stash pop'
alias gstc='git stash clear'
alias gpv='git push --verbose'
alias gp='git push'
alias glog='git log --oneline --decorate --graph'
alias glg='git log --stat'
alias gst='git status'
alias gb='git branch'
alias gl='git pull'

# Functions
function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Plugin configurations
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf - only load if installed
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

# Prompt - load near end
source ~/powerlevel10k/powerlevel10k.zsh-theme

# Syntax highlighting - must be loaded last
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Secrets and machine-local overrides - never committed
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local


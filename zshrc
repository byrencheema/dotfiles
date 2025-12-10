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

# Plugin configurations
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf - only load if installed
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

# Prompt - load near end
eval "$(starship init zsh)"

# Syntax highlighting - must be loaded last
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


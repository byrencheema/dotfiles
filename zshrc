# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Aliases and shell functions
[[ ! -f ~/.aliases ]] || source ~/.aliases

# Completion
autoload -Uz compinit && compinit
zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}" "r:|=*" "l:|=* r:|=*"
zstyle ":completion:*" menu select

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


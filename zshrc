# Kelly's .zprofile
#
# For Completion stuff
autoload -Uz compinit
compinit

# kubectl completions
source <(kubectl completion zsh)


# program aliases
alias vim='nvim'
alias v='nvim'

# Bat alias for pretty printing files
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  alias cat="bat"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  # Linux (Ubuntu)
  if command -v batcat &> /dev/null; then
    alias cat="batcat"
  else
    alias cat="bat" # Fallback if bat is installed as bat
  fi
fi

# ... rest of your .zshrc ...

# bring up this file easily
alias vz='nvim ~/.zshrc'

# cd aliases
alias cd..='cd ..'  # common typo
alias ..='cd ..'    # Quick directory navigation
alias ...='cd ../..'

# git aliases
alias gst='git status'
alias ga='git add'
alias gc='git commit'
# clear alias
alias c='clear'
# ls aliases
alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
alias llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons' 
alias la='eza --long --all --group --group-directories-first'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'

alias lS='eza -1 --color=always --group-directories-first --icons'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
alias l.="eza -a | grep -E '^\.'"

# WE NEED THIS FOR HOMEBREW!
eval "$(/opt/homebrew/bin/brew shellenv)"


# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# enable starship prompt
eval "$(starship init zsh)"

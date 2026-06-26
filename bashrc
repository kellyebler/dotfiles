# ~/.bashrc - Modern bash configuration with autocompletion and suggestions

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ============================================================================
# History Settings
# ============================================================================
HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoredups:erasedups
HISTTIMEFORMAT="%F %T "
shopt -s histappend
shopt -s cmdhist

# Save and reload history after each command
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# ============================================================================
# Shell Options
# ============================================================================
shopt -s checkwinsize      # Update LINES and COLUMNS after each command
shopt -s autocd 2>/dev/null       # cd by just typing directory name
shopt -s cdspell 2>/dev/null      # Autocorrect typos in cd
shopt -s dirspell 2>/dev/null     # Autocorrect typos in directory names
shopt -s nocaseglob 2>/dev/null   # Case-insensitive globbing

# ============================================================================
# Completion
# ============================================================================
# Enable bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Better tab completion
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set completion-map-case on'
bind 'set colored-stats on'
bind 'set visible-stats on'
bind 'set mark-symlinked-directories on'
bind 'set colored-completion-prefix on'
bind 'set menu-complete-display-prefix on'

# ============================================================================
# FZF - Fuzzy Finder
# ============================================================================
if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash

    # FZF settings
    export FZF_DEFAULT_OPTS="
        --height 40%
        --layout=reverse
        --border
        --inline-info
        --color=fg:#d0d0d0,bg:#121212,hl:#5f87af
        --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff
        --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
        --color=marker:#87ff00,spinner:#af5fff,header:#87afaf"

    # Use fd if available for faster searching
    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
fi

# ============================================================================
# Aliases
# ============================================================================
# ls aliases with colors
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# grep with color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Git aliases
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git pull'
alias gps='git push'
alias gl='git log --oneline --graph --decorate --all'
alias gco='git checkout'
alias gb='git branch'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

# Utility
alias h='history'
alias j='jobs -l'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# Quick edits
alias bashrc='${EDITOR:-vim} ~/.bashrc && source ~/.bashrc'

# ============================================================================
# Functions
# ============================================================================
# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Quick search in history
hs() {
    history | grep "$1"
}

# Extract various archive formats
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# ============================================================================
# Starship Prompt
# ============================================================================
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
else
    # Fallback to simple colored prompt if starship isn't installed
    PS1='\[\033[36m\]\u@\h\[\033[0m\]:\[\033[32m\]\w\[\033[0m\]\$ '
fi

# ============================================================================
# Local Customizations
# ============================================================================
# Load local customizations if they exist
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

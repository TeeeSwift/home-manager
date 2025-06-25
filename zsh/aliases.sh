# recursive directory search
alias rd='cd "$(dirs -v | awk '\''!seen[$2]++ {print $2}'\'' | fzf --height 50% --reverse | sed "s|~|$HOME|")"'

# make directories bold
alias l='tree -L 1 -C --dirsfirst'
alias ls='ls --color=auto'
alias ll='ls -l'

# aliases
alias ..='cd ..'
alias vim='nvim'
alias ~='cd ~'
alias v='nvim .'
alias c='clear'

# tmux
alias tm='tmux a'
alias tmls='tmux ls'
alias tma='tmux attach -t'
alias tmd='tmux detach'
alias tmk='tmux kill-session -t '

# git
alias gs='git status'
alias gl='git log --oneline'
alias gw='git switch'

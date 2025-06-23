bindkey -v
setopt AUTO_PUSHD

function parse_git_branch() {
  local branch_name
    branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    if [[ -n "$branch_name" ]]; then
        echo -n "[${branch_name}%f] "  # Add a space after the closing bracket
    fi
}

function update_prompt() {
    PS1="$(parse_git_branch)🐈 "
}

# Set the prompt and hook
update_prompt
precmd() {
    update_prompt
}

RPROMPT='%~'

# case insensitive tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

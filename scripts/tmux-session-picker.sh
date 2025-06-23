#!/bin/bash

# Pre-modification
if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(tmux list-sessions -F "#{session_name}" | fzf)
fi

if [[ -z $selected ]]; then
  exit 0
fi
tmux_running=$(pgrep tmux)

if [[ $TMUX ]] && [[ $tmux_running ]]; then
    tmux switch -t $selected
    exit 0
fi

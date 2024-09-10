#!/usr/bin/env bash

function tmux_kitty_preview {
   echo -e "Loading preview...\nFile: ${1} \n"
   if ! command -V tmux &> /dev/null; then
      echo "tmux could not be found in your PATH.\n\nPlease install it to display media content."
      exit 127
  fi

  if ! command -v kitty &> /dev/null; then
      echo "kitty could not be found in your PATH.\n\nPlease install it to display media content."
      exit 127
  fi
  current_pane_index=$(tmux display-message -p '#{pane_index}')
  pane_index_configured="$4"
  if [ "$current_pane_index" -eq "$pane_index_configured" ]; then
    stderr="Tmux index pane configuration: The pane index configured ${pane_index_configured}"
    stderr="${stderr}, can not the same for the vim editor ${current_pane_index}."
    echo "${stderr}" # Show error in the console.
    tmux send-keys -t "${4}" "${stderr}" C-m # Send error message to current pane console.
    exit 1
  fi

  num_panes=$(tmux list-panes | wc -l)
  if [[ "$num_panes" -eq 1 ]] || [[ "$2" -eq 1 ]]; then 
    tmux split-window -h
    if [ "$6" -ge 1 ]; then
      tmux resize-pane -x "$6"
    fi
fi

  if [ "$pane_index_configured" -lt 0 ]; then
    pane_index_configured=$(("${current_pane_index}" + 1))
  fi
  tmux select-pane -t "$pane_index_configured"
  command_show_image="$5"" '$1'"
  tmux send-keys -t "$pane_index_configured" "${command_show_image}" C-m
  sleep $3

  tmux select-pane -t "$current_pane_index"
}

tmux_kitty_preview "${@}"
read

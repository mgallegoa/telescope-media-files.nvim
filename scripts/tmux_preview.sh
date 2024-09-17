#!/usr/bin/env bash

# This bash file allow work with Tmux panes.
# After configure the pane, it call the default bash to show the thumbnail but in the new pane created.
# This bash call to the file ./default_preview.sh to show the Thumbnails, using the same
#   configuration for the file types allowed. Ejm: jpeg, pdf, mp4, ttf, svg, gif
function tmux_preview {
   if ! command -V tmux &> /dev/null; then
      printf "tmux could not be found in your PATH.\n\nPlease install it to display media content."
      exit 127
  fi

  file_name=${1}
  printf "Loading Tmux preview...\nFile: ${file_name} \n"
  command_thumbnail="${2}"
  tmux_always_open_pane="${3}"
  tmux_time_wait="${4}"
  tmux_index_pane_thumbnail="${5}"
  tmux_resize_open_pane="${6}"
  path_default_preview="${7}"
  show_file_details="${8}"

  current_pane_index=$(tmux display-message -p '#{pane_index}')
  if [[ "$current_pane_index" -eq "$tmux_index_pane_thumbnail" ]]; then
    stderr="Tmux index pane configuration: The pane index configured ${tmux_index_pane_thumbnail}"
    stderr="${stderr}, can not the same for the vim editor ${current_pane_index}."
    printf "${stderr}" # Show error in the console.
    tmux send-keys -t "${tmux_index_pane_thumbnail}" "${stderr}" C-m # Send error message to current pane console.
    exit 1
  fi
  # Check if a pane need to be open.
  num_panes=$(tmux list-panes | wc -l)
  if [[ "${num_panes}" -eq 1 ]] || [[ "${tmux_always_open_pane}" -eq 1 ]]; then
    tmux split-window -h
    if [ "${tmux_resize_open_pane}" -ge 1 ]; then
      tmux resize-pane -x "${tmux_resize_open_pane}"
    fi
  fi
  # Validation if only exist one pane, it is necessary to
  # send the commands to ne next opened pane.
  if [[ "${tmux_index_pane_thumbnail}" -lt 0 ]]; then
    tmux_index_pane_thumbnail=$(("${current_pane_index}" + 1))
  fi
  tmux select-pane -t "${tmux_index_pane_thumbnail}"
  # Capture the dimensions of the current pane
  pane_size=$(tmux display-message -p "#{pane_height}x#{pane_width}")
  # Extract height and width from the output
  width=$(echo $pane_size | cut -d'x' -f2)
  height=$(echo $pane_size | cut -d'x' -f1)
  command_script_params="$path_default_preview '${file_name}' ${width} ${height} '${command_thumbnail}' ${show_file_details}"
  tmux send-keys -t "${pane_index_configured}" "${command_script_params}" C-m


  sleep "${tmux_time_wait}"

  tmux select-pane -t "$current_pane_index"
  true
}

tmux_preview "${@}"
read

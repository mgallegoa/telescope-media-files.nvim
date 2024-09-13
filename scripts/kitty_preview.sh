#!/usr/bin/env bash

# This bash file allow work with kitty windows.
# After configure the kitty window, it call the default bash to show the thumbnail but in the new window created.
# This bash call to the file ./default_preview.sh to show the Thumbnails, using the same
#   confgiuration for the file types allowed. Ejm: jpeg, pdf, mp4, ttf, svg, gif
function kitty_preview {
  if ! command -v kitty &> /dev/null; then
      printf "kitty could not be found in your PATH.\n\nPlease install it to display media content."
      exit 127
  fi
  file_name=${1}
  printf "Loading kitty preview...\nFile: ${file_name} \n"
  command_thumbnail="${2}"
  kitty_always_open_window="${3}"
  kitty_time_wait="${4}"
  kitty_id_window_thumbnail="${5}"
  kitty_resize_open_window="${6}"
  path_default_preview="${7}"

  # TODO: This command fire an error in some machines that not
  # support server comunications.
  # Enable the control socket to interact with kitty
  kitty -o allow_remote_control=yes -o enabled_layouts=tall

  current_window_id=$(kitty @ ls | jq -r '.windows[] | select(.current == true) | .id')
  if [[ "$current_window_id" -eq "$kitty_id_window_thumbnail" ]]; then
    stderr="kitty id window configuration: The window id configured ${kitty_id_window_thumbnail}"
    stderr="${stderr}, can not the same for the vim editor ${current_window_id}."
    printf "${stderr}" # Show error in the console.
    kitty @ send-text --to="${kitty_id_window_thumbnail}" "${stderr}" C-m # Send error message to current window console.
    exit 1
  fi
  # Check if a window need to be open. jq program is required to be installed.
  num_windows=$(kitty @ ls | jq '[.windows[] | select(.tab == (.tabs[] | select(.current == true) | .id))] | length')
  if [[ "${num_windows}" -eq 1 ]] || [[ "${kitty_always_open_window}" -eq 1 ]]; then
    kitty_id_window_thumbnail=$(kitten @ launch --title=Tumbnail mutt)
    if [ "${kitty_resize_open_window}" -ge 1 ]; then
      kitty resize-window -x "${kitty_resize_open_window}"
    fi
  fi
  # Validation if only exist one window, it is necesary to
  # send the commands to ne next opend window.
  if [[ "${kitty_id_window_thumbnail}" -lt 0 ]]; then
    kitty_id_window_thumbnail=$(("${current_window_id}" + 1))
  fi
  kitten @ focus-window --id "${kitty_id_window_thumbnail}"
  # Extract height and width from the output
  width=$(kitty @ ls | jq -r '.windows[] | select(.id == "12345") | .width')
  height=$(kitty @ ls | jq -r '.windows[] | select(.id == "12345") | .height')
  command_script_params="$path_default_preview '${file_name}' ${width} ${height} '${command_thumbnail}'"
  kitty @ exec --to="${window_id_configured}" "${command_script_params}"


  sleep "${kitty_time_wait}"

  kitten @ focus-window --id "${current_window_id}"
  true
}

kitty_preview "${@}"
read

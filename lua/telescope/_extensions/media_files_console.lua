local M = {}

function M.preview_custom_console(selected_value, config_media)
  local path_nvim_media_file = require('plenary.debug_utils').sourced_filepath()
  local path_nvim_media = vim.fn.fnamemodify(path_nvim_media_file, ":h:h:h:h")
  local filename = selected_value
  local params = {
    filename,                                 -- Image to show.
    config_media.tmux_always_open_pane,       -- Does always open a new pane? 0 No, 1 Yes.
    config_media.tmux_time_wait,              -- Time in seconds, to wait to load the image.
    config_media.tmux_index_pane_thumbnail,   -- Index of the Tmux pane to show the image, Tmux pane start from 0. Let -1 to desable.
    config_media.tmux_command_show_thumbnail, -- Command to execute to open the Thumbnail.
    config_media.tmux_resize_open_pane,       -- Number of columns to resize the opened pane.
  }

  local command = { path_nvim_media .. '/scripts/tmux_kitty_preview.sh', table.unpack(params) }
  vim.fn.jobstart(command, {
    on_stdout = function(_, _, _)
      -- vim.notify("Correct! ")
    end,
    on_stderr = function(_, data, _)
      vim.notify("Error: " .. table.concat(data, "\n"))
    end,
    on_exit = function(_, exit_code, _)
      vim.notify("Exit code: " .. exit_code)
    end
  })
end

return M

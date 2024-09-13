local M = {}

-- This method validate if is installed the program configured to find.
-- The default program to find is fd.
--
function M.get_files(find_cmd, file_types)
  local error_message = "You don't have " .. find_cmd .. "! Install it first or use other finder."
  if not vim.fn.executable(find_cmd) then
    vim.notify(error_message)
    error(error_message)
    return
  end
  local find_commands = M.get_find_command(file_types)

  if not find_commands[find_cmd] then
    error_message = find_cmd .. ", this command to find, is not supported in your system, check configuration!"
    vim.notify(error_message)
    error(error_message)
    return
  end
  return find_commands[find_cmd]
end

-- This method return an object with differents program used to find files.
--
function M.get_find_command(file_types)
  local command = {
    find = {
      'find',
      '.',
      '-iregex',
      [[.*\.\(]] .. table.concat(file_types, "\\|") .. [[\)$]]
    },
    fd = {
      'fd',
      '--type',
      'f',
      '--regex',
      [[.*.(]] .. table.concat(file_types, "|") .. [[)$]],
      '.'
    },
    fdfind = {
      'fdfind',
      '--type',
      'f',
      '--regex',
      [[.*.(]] .. table.concat(file_types, "|") .. [[)$]],
      '.'
    },
    rg = {
      'rg',
      '--files',
      '--glob',
      [[*.{]] .. table.concat(file_types, ",") .. [[}]],
      '.'
    },
  }
  return command
end

-- Return the table object with the configuration params to execute the sh for tmux
--
function M.get_tmux_command(config_media)
  -- Dev note: this default command should be placed here for not interfiered in the default picker thumbnail.
  local command_thumbnail = "kitten icat"
  if config_media.command_open_thumbnail ~= "" then
    command_thumbnail = config_media.command_open_thumbnail
  end
  local config = {
    config_media.file_name,                 -- Image to show.
    command_thumbnail,                      -- Command to execute to open the Thumbnail.
    config_media.tmux_always_open_pane,     -- Does always open a new pane? 0 No, 1 Yes.
    config_media.tmux_time_wait,            -- Time in seconds, to wait to load the image.
    config_media.tmux_index_pane_thumbnail, -- Index of the Tmux pane to show the image, Tmux pane start from 0. Let -1 to desable.
    config_media.tmux_resize_open_pane,     -- Number of columns to resize the opened pane.
    config_media.path_default_preview,      -- Contain the path to the file script to show the Thumbnail.
  }
  local command = { config_media.path_nvim_media .. '/scripts/tmux_preview.sh', table.unpack(config) }
  return command
end

-- Return the table object with the configuration params to execute the sh for kitty
--
function M.get_kitty_command(config_media)
  -- Dev note: this default command should be placed here for not interfiered in the default picker thumbnail.
  local command_thumbnail = "kitten icat"
  if config_media.command_open_thumbnail ~= "" then
    command_thumbnail = config_media.command_open_thumbnail
  end
  local config = {
    config_media.file_name,                    -- Image to show.
    command_thumbnail,                         -- Command to execute to open the Thumbnail.
    config_media.kitty_always_open_window,     -- Does always open a new window? 0 No, 1 Yes.
    config_media.kitty_time_wait,              -- Time in seconds, to wait to load the image.
    config_media.kitty_index_window_thumbnail, -- Id of the kitty windows to show the image.
    config_media.kitty_resize_open_window,     -- Number of columns to size the opened window.
    config_media.path_default_preview,         -- Contain the path to the default file script to show the Thumbnail.
  }
  local command = { config_media.path_nvim_media .. '/scripts/kitty_preview.sh', table.unpack(config) }
  return command
end

return M

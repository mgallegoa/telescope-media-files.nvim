local utils_media = require('telescope.utils_media')
local M = {}

function M.preview_custom_console(selected_value, config_media)
  local file_name = config_media.cwd
  if selected_value:sub(1, 1) == "." then
    file_name = file_name .. selected_value:sub(2)
  else
    file_name = file_name .. selected_value
  end
  config_media.file_name = file_name
  config_media.path_default_preview = utils_media.get_default()
  config_media.path_nvim_media = utils_media.get_path_nvim_media()
  local command = utils_media.get_tmux_command(config_media)
  if config_media.external_environment == "kitty" then
    command = utils_media.get_kitty_command(config_media)
  end
  M.execute_command(command)
end

function M.execute_command(command)
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

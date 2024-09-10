local M = {}

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

return M

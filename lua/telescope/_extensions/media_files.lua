local has_telescope = pcall(require, "telescope")

if not has_telescope then
  local error_message = "This plugin requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)"
  vim.notify(error_message)
  error(error_message)
end


local utils = require('telescope.utils')
local defaulter = utils.make_default_callable
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')
local conf = require('telescope.config').values

local utils_media = require('telescope.utils_media')
local media_files_console = require('telescope._extensions.media_files_console')

local M = {}
local filetypes = {}
local find_cmd = ""
local image_stretch = 250
M.config_media = {}


-- Default preview: use new_termopen_previewer to create the console
M.media_preview = defaulter(function(opts)
  return previewers.new_termopen_previewer {
    title = "Thumbnails",
    get_command = opts.get_command or function(entry)
      local tmp_table = vim.split(entry.value, "\t");
      local preview = opts.get_preview_window()
      opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
      M.config_media.cwd = opts.cwd
      if vim.tbl_isempty(tmp_table) then
        return { "echo", "" }
      end
      return {
        M.base_directory .. '/scripts/default_preview.sh',
        string.format([[%s/%s]], opts.cwd, tmp_table[1]),
        preview.width,
        preview.height,
        M.config_media.command_open_thumbnail,
        preview.col,
        preview.line + 1,
        image_stretch
      }
    end
  }
end, {})

function M.media_files(opts)
  local path_nvim_media_file = require('plenary.debug_utils').sourced_filepath()
  M.base_directory = vim.fn.fnamemodify(path_nvim_media_file, ":h:h:h:h")
  opts = opts or {}
  opts.attach_mappings = function(_, map)
    local selection
    map({ 'i', 'n' }, '<C-i>', function()
      selection = action_state.get_selected_entry()
      M.config_media.file_name = utils_media.get_completed_path(M.config_media, selection.value)
      M.config_media.path_default_preview = utils_media.get_default()
      local command = utils_media.get_command_open_image(M.config_media)
      media_files_console.execute_command(command)
    end)
    map({ 'i', 'n' }, '<CR>', function(_)
      selection = action_state.get_selected_entry()
      vim.fn.setreg(vim.v.register, selection.value)
      -- vim.notify("The image path has been copied!" .. selection.value)
    end)
    return true
  end
  opts.path_display = { "shorten" }

  local popup_opts = {}
  opts.get_preview_window = function()
    return popup_opts.preview
  end
  local picker = pickers.new(opts, {
    prompt_title = 'Media Files',
    finder = finders.new_oneshot_job(
      utils_media.get_files(find_cmd, filetypes),
      opts
    ),
    previewer = M.media_preview.new(opts),
    sorter = conf.file_sorter(opts),
  })
  local line_count = vim.o.lines - vim.o.cmdheight
  if vim.o.laststatus ~= 0 then
    line_count = line_count - 1
  end
  popup_opts = picker:get_window_options(vim.o.columns, line_count)
  picker:find()
end

function M.media_files_console()
  M.config_media.cwd = vim.loop.cwd()
  pickers.new({
    prompt_title = "Media Files Console",
    finder = finders.new_oneshot_job(
      utils_media.get_files(find_cmd, filetypes), {
        cwd = vim.fn.expand('%:p:h'),
      }),
    sorter = sorters.get_fuzzy_file(),
    attach_mappings = function(_, map)
      map({ 'i', 'n' }, '<C-i>', function()
        local selection = action_state.get_selected_entry()
        M.config_media.file_name = utils_media.get_completed_path(M.config_media, selection.value)
        M.config_media.path_default_preview = utils_media.get_default()
        local command = utils_media.get_command_open_image(M.config_media)
        media_files_console.execute_command(command)
      end)
      map({ 'i', 'n' }, '<C-t>', function()
        local selection = action_state.get_selected_entry()
        media_files_console.preview_custom_console(selection.value, M.config_media)
      end)
      map({ 'i', 'n' }, '<CR>', function()
        local selection = action_state.get_selected_entry()
        media_files_console.preview_custom_console(selection.value, M.config_media)
        vim.fn.setreg(vim.v.register, selection.value)
        -- vim.notify("The image path has been copied!" .. selection.value)
      end)
      return true
    end,
  }):find()
end

return require('telescope').register_extension {
  setup = function(ext_config)
    filetypes = ext_config.filetypes or { "png", "jpg", "jpeg", "svg" }
    find_cmd = ext_config.find_cmd or "fd"
    image_stretch = ext_config.image_stretch or 250
    M.config_media.command_open_image = ext_config.command_open_image or "eog"
    M.config_media.command_open_thumbnail = ext_config.command_open_thumbnail or "chafa --center=on --clear --colors=full -w 9 "

    M.config_media.external_environment = ext_config.external_environment or "tmux"
    M.config_media.kitty_always_open_window = ext_config.kitty_always_open_window or 0
    M.config_media.kitty_time_wait = ext_config.kitty_time_wait or 0
    M.config_media.kitty_index_window_thumbnail = ext_config.kitty_index_window_thumbnail or -1
    M.config_media.kitty_resize_open_window = ext_config.kitty_resize_open_window or 0


    M.config_media.tmux_always_open_pane = ext_config.tmux_always_open_pane or 0
    M.config_media.tmux_time_wait = ext_config.tmux_time_wait or 0
    M.config_media.tmux_index_pane_thumbnail = ext_config.tmux_index_pane_thumbnail or -1
    M.config_media.tmux_resize_open_pane = ext_config.tmux_resize_open_pane or 0
  end,
  exports = {
    media_files = M.media_files,
    media_files_console = M.media_files_console,
  },
}

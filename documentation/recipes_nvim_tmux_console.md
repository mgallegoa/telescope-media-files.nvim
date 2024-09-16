# Recipe Nvim + Tmux

### Objective:
Document the possibles configurations supported with Tmux. Each section have associate a video helpful showing the result for each configuration.

In this section show the configuration with tmux and console that doesn't support render images. If your console support render images like kitty (using kitten icat) to show the images, see the section [Tmux + Kitty](recipes_nvim_tmux_kitty.md). This could be extended to other consoles that support rendering images.

## Nvim + Tmux

Tmux work with nvim internal console and can render ASCII Art out of the box, you can view the Thumbnails with Nvim+Tmux like you see working you with Nvim.

[video telescope-media-file-tmux-default.webm](https://mgallegoa.github.io/telescope-media-files/telescope-media-file-tmux-default.webm)



## Nvim + Tmux (working with panes)

This is allowed thanks to the Tmux ability to open new panes and use opend panes. In the new pane a console is open and render the Thumbnail.

This examples is for consoles doesn't support render images, for consoles that support [render images, see the section Tmux + Kitty](recipes_nvim_tmux_kitty.md) 

[video telescope-media-file-tmux-console.webm](https://mgallegoa.github.io/telescope-media-files/telescope-media-file-tmux-console.webm)


> 💡 **Tip:** You can also use the two methods at the same time media_files() and media_files_console()

> ⚠️ **Warning for console:** With gif files and used of panes, chafa by default loop to infinite the gif, in some consoles this block the console, if you experiment this behavior can send the flag duration to the number of seconds in the config variable. For example: command_open_thumbnail="chafa --center=on --clear --colors=full -w 9 --duration=5 "

Next, commented the custom values for the configuration variables used for the videos example -->
```lua

    config = function()
      local telescope = require('telescope')
      telescope.setup({
        extensions = {
          media_files = {
            filetypes = { "png", "jpg", "jpeg", "webp", "svg", "gif", "pdf", "epub", "ttf", "mp4", "3gp", "mpeg" }, -- default {"png", "jpg", "mp4", "webm", "pdf"}
            find_cmd = "rg",                                                                                        -- find command defaults to `fd`
            -- command_open_imen = "display" -- Example to use imageMagick to show the image instead default eog
            -- tmux_always_open_pane = 1
            -- tmux_time_wait = 3
            -- tmux_index_pane_thumbnail = 0
            -- tmux_resize_open_pane = 30
          }
        },
      })
    end,
    keys = {
      { "<leader>fm", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>" },
      { "<leader>fn", "<cmd>lua require('telescope').extensions.media_files.media_files_console()<cr>" },
    }

```

### Manage if always open a new pane in Tmux to show the Thumbnail (tmux_always_open_pane)

This is allowed by configuring the tmux_always_open_pane in the setup for the telescope-media-files plugin.

Default value 0 change to 1: This config variable indicate to the telescope-media-file plugin if always open a new pane to show the Thumbnail (the default behavior is to verify if a pane index 1 is opened and use it to show the Thumbnail or create a new pane if index 1 doesn't exist)

[video telescope-media-file-tmux-alway-open-pane.webm](https://mgallegoa.github.io/telescope-media-files/telescope-media-file-tmux-alway-open-pane.webm)


### Configure the time to wait to render an image in console to show the Thumbnail (tmux_time_wait)

This is allowed by configuring the tmux_time_wait in the setup for the telescope-media-files plugin. Render an image in console can be heavy and the console need some time to render it, with this variable you can manage this time.

Default value 0 change to 'number value': This config variable indicate to the telescope-media-file plugin if the console render need to wait some time to show the Thumbnail.

[video telescope-media-file-tmux_time_wait.webm](https://mgallegoa.github.io/telescope-media-files/telescope-media-file-tmux_time_wait.webm)


### Manage the pane to show the Thumbnail (tmux_index_pane_thumbnail)

This is allowed by configuring the tmux_index_pane_thumbnail in the setup for the telescope-media-files plugin.

Default value -1 change to 0 or other index pane number: You have to prepare the panes in your Tmux work space and see the index pane that you want to show the image, Ctrl+b+q in Tmux to show the pane index.

[video telescope-media-file-tmux-console.webm](https://mgallegoa.github.io/telescope-media-files/telescope-media-file-tmux-console.webm)


### Configure the number of columns to size the new pane to show the Thumbnail (tmux_resize_open_pane)

This is allowed by configuring the tmux_resize_open_pane in the setup for the telescope-media-files plugin.

Default value 0 change to 'number value': This config variable indicate to the telescope-media-file plugin if the new pane is sized to a specific column number. The panes in Tmux always open in the half of the screen, with this config variable you can change this behavior.

Example video the new pane is configured to 30 columns -->

[video telescope-media-file-tmux_resize_open_pane.webm](https://mgallegoa.github.io/telescope-media-files/telescope-media-file-tmux_resize_open_pane.webm)




# Telescope-media-files.nvim
Preview images Thumbnails for different kind of files, from Neovim using Telescope + ASCII Art (whit Chafa). Support Tmux + console kitty.

jpg | png | jpeg | svg | gif | avi | mp4 | wmv | dat | 3gp | ogv | mkv | mpg | mpeg | vob |  m2v | mov | webm | mts | m4v | rm  | qt | divx | pdf | epub | ttf | otf | woff | webp

### Nvim
![Nvim](documentation/Telescope-media-file-nvim.gif)
### Nvim + Tmux + Kitty
![Tmux+kitty](documentation/Telescope-media-file-tmux-kitty.gif)

> ⭐ **Important:** If you like, let your star

## Videos
1. [Configuration](https://www.youtube.com/watch?v=r7539o5ulu4) 
2. [Tmux + Kitty](https://www.youtube.com/watch?v=e39cPaOP4fE)


## Install
### Lazy
```Lazy
return {
    "mgallegoa/telescope-media-files.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/popup.nvim"
    },
}
```
## Setup

``` lua
require('telescope').load_extension('media_files')

```

## Custom Configuration
This extension can be configured using `extensions` field inside Telescope setup function.

### Example custom configuration with Lazy
In the next example, the filetypes is configure to accept other types of files (check the Prerequisites section optional) and change the default find command (fd) to rg -->
```lua

    config = function()
      local telescope = require('telescope')
      telescope.setup({
        extensions = {
          media_files = {
            filetypes = { "png", "jpg", "jpeg", "webp", "svg", "gif", "pdf", "epub", "ttf", "mp4", "3gp", "mpeg" }, -- default {"png", "jpg", "mp4", "webm", "pdf"}
            find_cmd = "rg", -- find command defaults to `fd`
            -- command_open_imen = "display" -- Example to use imageMagick to show the image instead default eog
            -- command_open_image = 'gnome-terminal -- env TMUX="" kitty --hold kitten ica' -- Example to use the kitty terminal for the images
            -- command_open_thumbnail = "kitten icat" -- Example open image Thumbnail with kitty
            -- show_file_details = 0 -- Example to disable the file details.
            -- tmux_always_open_pane = 1 -- Example to open a new pane in tmux for each Thumbnail
            -- tmux_time_wait = 1 -- Example to wait 1 second for console render the image
            -- tmux_index_pane_thumbnail = 0 -- Example to show the Thumbnail at the left of the tmux pane.
            -- tmux_resize_open_pane = 30 -- Example of number of columns to open the tmux pane.
          }
        },
      })
    end,
    keys = {
      { "<leader>fm", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>" },
      { "<leader>fn", "<cmd>lua require('telescope').extensions.media_files.media_files_console()<cr>" },
    }

```
> 💡 **Tip:** [See the list of the config variables you can used to custom your view](documentation/config_variables.md)

## Available commands
Over the file Ctl+i to open an image of the file (default viewer eog, but can be configured to other external viewer)
```viml
:Telescope media_files

lua require('telescope').extensions.media_files.media_files()
lua require('telescope').extensions.media_files.media_files_console()
```
or using key-binding
```lua
:Telescope media_files.media_files()
:Telescope media_files.media_files_console()

keys = {
      { "<leader>fm", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>" },
      { "<leader>fn", "<cmd>lua require('telescope').extensions.media_files.media_files_console()<cr>" },
    }
```

When you press `<Enter>` on a selected file, normal mode, it will copy its relative path to the clipboard

## Recipes
* [Nvim](documentation/recipes_nvim_console.md)
* [Nvim + Tmux](documentation/recipes_nvim_tmux_console.md)
* [Nvim + Tmux + kitty](documentation/recipes_nvim_tmux_kitty.md)


## Prerequisites
### Requiered
* [Chafa](https://hpjansson.org/chafa/) : ASCII Art Image support ( Tmux + kitten required kitten icat )
* [fd](https://manpages.ubuntu.com/manpages/focal/man1/fdfind.1.html) : To find the files in Telescope pop up. Also support [rg](https://github.com/BurntSushi/ripgrep) / [find](https://man7.org/linux/man-pages/man1/find.1.html), find or fdfind in Ubuntu/Debian.

### Optionals
* [file](https://github.com/file/file) : To view detailed information for the file at the buttom of the Thumbnail
* [rsvg-convert](https://manpages.ubuntu.com/manpages/trusty/man1/rsvg-convert.1.html) : For svg previews
* [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer) : for video preview support
* [pdftoppm](https://linux.die.net/man/1/pdftoppm) : for pdf preview support. Available in the AUR as **poppler** package.
* [epub-thumbnailer](https://github.com/marianosimone/epub-thumbnailer) : for epub preview support.
* [fontpreview](https://github.com/sdushantha/fontpreview) : for font preview support. But it is necessary to install imageMagic version > 7 to work correctly (https://github.com/ImageMagick/ImageMagick) and follow the insatallation accourding to your system, for example in Unix (https://github.com/ImageMagick/ImageMagick/blob/main/Install-unix.txt)
* [ffmpeg](https://www.ffmpeg.org/) : Use for webp previews.

## Other usefull documents pages
* [Know errors/issues and how to fix](documentation/errors_issues_knows.md) contain a list of know and document errors/issues and how to fix it.
* [Tested environments](documentation/tested_environments.md) contain information of different environments test and work well.



credit to https://github.com/cirala/vifmimg

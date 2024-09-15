# Telescope-media-files.nvim
Preview images, gif, pdf, epub, video, and fonts from Neovim using Telescope + ASCII Art (whit Chafa). Support Tmux + console kitty

### Nvim
![Nvim](documentation/Telescope-media-file-nvim.gif)
### Nvim + Tmux + Kitty
![Tmux+kitty](documentation/Telescope-media-file-tmux-kitty.gif)

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
In the next example, the filetypes is configure to acept other types of files (check the Prerequisites section optionals) and change the default find command (fd) to rg -->
```lua

    config = function()
      local telescope = require('telescope')
      telescope.setup({
        extensions = {
          media_files = {
            -- Change the defaults list { "png", "jpg", "jpeg", "svg" },
            filetypes = { "png", "jpg", "jpeg", "webp", "svg", "gif", "pdf", "epub", "ttf", "mp4", "3gp", "mpeg" },
            -- Change the default find command (defaults is `fd`)
            find_cmd = "rg"
          }
        },
      })
    end,
    keys = {
      { "<leader>fm", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>" },
      { "<leader>fn", "<cmd>lua require('telescope').extensions.media_files.media_files_console()<cr>" },
    }

```
> 💡 **Tip:** [See the list of the config variables you can used to custom your view](documents/config_variables.md)

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
* [Nvim + Console](documentation/recipes_nvim_console.md) contain example with kitty console.
* [Nvim + Tmux + Console](documentation/recipes_nvim_tmux_console.md) contain example with kitty console.


## Prerequisites
### Requiered
* [Chafa](https://hpjansson.org/chafa/) (required for image support)
* [fd](https://manpages.ubuntu.com/manpages/focal/man1/fdfind.1.html)
### Optionals
* [file](https://github.com/file/file) : To view detailed information for the file at the buttom of the Thumbnail
* [rg](https://github.com/BurntSushi/ripgrep) / [find](https://man7.org/linux/man-pages/man1/find.1.html) or fdfind in Ubuntu/Debian.
* [rsvg-convert](https://manpages.ubuntu.com/manpages/trusty/man1/rsvg-convert.1.html) : For svg previews
* [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer) : for video preview support
* [pdftoppm](https://linux.die.net/man/1/pdftoppm) : for pdf preview support. Available in the AUR as **poppler** package.
* [epub-thumbnailer](https://github.com/marianosimone/epub-thumbnailer) : for epub preview support.
* [fontpreview](https://github.com/sdushantha/fontpreview) : for font preview support. But it is necessary to instal imageMagic version > 7 to work correctly (https://github.com/ImageMagick/ImageMagick) and follow the insatallation accourding to your system, for example in Unix (https://github.com/ImageMagick/ImageMagick/blob/main/Install-unix.txt)
* [ffmpeg](https://www.ffmpeg.org/) : Use for webp previews.

## Other usefull documents pages
* [Know errors/issues and how to fix](documentation/errors_issues_knows.md) contain the a list of know and document errors/issues and how to fix it.
* [Tested environments](documentation/tested_environments.md) contain information of differents environments test and work well.



credit to https://github.com/cirala/vifmimg

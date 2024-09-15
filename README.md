# Telescope-media-files.nvim
Preview images, gif, pdf, epub, video, and fonts from Neovim using Telescope. Support Tmux + kitty

### Nvim
![Nvim](Telescope-media-file-nvim.gif)
### Nvim + Tmux + Kitty
![Tmux+kitty](Telescope-media-file-tmux-kitty.gif)

<div style="display: flex; justify-content: space-around;">
  <img src="Telescope-media-file-nvim.gif" alt="Nvim" style="width: 45%;"/>
  <img src="Telescope-media-file-tmux-kitty.gif" alt="Tmux+kitty" style="width: 45%;"/>
</div>


## Install
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

## Configuration
This extension can be configured using `extensions` field inside Telescope
setup function.

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

## Available commands
```viml
:Telescope media_files

"Using lua function
lua require('telescope').extensions.media_files.media_files()
lua require('telescope').extensions.media_files.media_files_console()
```
or using key-binding
```viml
:Telescope media_files

"Using lua function
keys = {
      { "<leader>fm", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>" },
      { "<leader>fn", "<cmd>lua require('telescope').extensions.media_files.media_files_console()<cr>" },
    }
```

When you press `<Enter>` on a selected file, normal mode, it will copy its relative path to the clipboard


## Prerequisites
* [Chafa](https://hpjansson.org/chafa/) (required for image support)
* [file](https://github.com/file/file) (optional, to view detailed information for the file)
* [rsvg-convert](https://manpages.ubuntu.com/manpages/trusty/man1/rsvg-convert.1.html) (optional, for svg previews)
* [fd](https://github.com/sharkdp/fd) / [rg](https://github.com/BurntSushi/ripgrep) / [find](https://man7.org/linux/man-pages/man1/find.1.html) or fdfind in Ubuntu/Debian.
* [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer) (optional, for video preview support)
* [pdftoppm](https://linux.die.net/man/1/pdftoppm) (optional, for pdf preview support. Available in the AUR as **poppler** package.)
* [epub-thumbnailer](https://github.com/marianosimone/epub-thumbnailer) (optional, for epub preview support.)
* [fontpreview](https://github.com/sdushantha/fontpreview) (optional, for font preview support). But it is necessary to instal imageMagic version > 7 to work correctly (https://github.com/ImageMagick/ImageMagick) and follow the insatallation accourding to your system, for example in Unix (https://github.com/ImageMagick/ImageMagick/blob/main/Install-unix.txt)
* webp (optional): Use the [ffmpeg](https://www.ffmpeg.org/) command to convert to image.

credit to https://github.com/cirala/vifmimg

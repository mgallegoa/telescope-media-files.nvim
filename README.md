# Telescope-media-files.nvim
Preview images, gif, pdf, epub, video, and fonts from Neovim using Telescope.

![Demo](https://i.imgur.com/wEO04TK.gif)

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
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "jpg", "jpeg", "svg","gif", "pdf" },
            -- find command (defaults to `fd`)
            find_cmd = "rg"
          }
        },
      })
    end,
    keys = {
      { "<leader>fm", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>" },
    }

```

## Available commands
```viml
:Telescope media_files

"Using lua function
lua require('telescope').extensions.media_files.media_files()
```

When you press `<CR>` on a selected file, it will copy its relative path to the clipboard


## Prerequisites
* [Chafa](https://hpjansson.org/chafa/) (required for image support)
* [file](https://github.com/file/file) (optional, to view detailed information for the file)
* [rsvg-convert](https://manpages.ubuntu.com/manpages/trusty/man1/rsvg-convert.1.html) (optional, for svg previews)
* [fd](https://github.com/sharkdp/fd) / [rg](https://github.com/BurntSushi/ripgrep) / [find](https://man7.org/linux/man-pages/man1/find.1.html) or fdfind in Ubuntu/Debian.
* [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer) (optional, for video preview support)
* [pdftoppm](https://linux.die.net/man/1/pdftoppm) (optional, for pdf preview support. Available in the AUR as **poppler** package.)
* [epub-thumbnailer](https://github.com/marianosimone/epub-thumbnailer) (optional, for epub preview support.)
* [fontpreview](https://github.com/sdushantha/fontpreview) (optional, for font preview support). But it is necessary to instal imageMagic version > 7 to work correctly (https://github.com/ImageMagick/ImageMagick) and follow the insatallation accourding to your system, for example in Unix (https://github.com/ImageMagick/ImageMagick/blob/main/Install-unix.txt)

credit to https://github.com/cirala/vifmimg

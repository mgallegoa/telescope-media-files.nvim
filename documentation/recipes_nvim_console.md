# Recipe Nvim

The internal nvim terminal don't support render images, in this case, the image Thumbnail is render using ASCII Art with chafa.

### Objective:
Document the possibles configurations supported if the console can not render images (used ASSCII Art).

## Nvim + Console (don't support render images)

In this case the default configuration should work well, the default configuration use [Chafa](https://hpjansson.org/chafa/) to render ASCII Art support for consoles.

[video telescope-media-file.webm](https://mgallegoa.github.io/telescope-media-files/telescope-media-file.webm)


## Nvim + Kitty (support render images)

Kitty can render images in console, but the internal nvim terminal not, a work around for this is open a new kitty window to allow render images, add the configurable variable command_open_image value for open the Thumbnail, and you can open it with Ctrl+i:

command_open_image = 'gnome-terminal -- env TMUX="" kitty --hold kitten ica'

Now you can open a project in kitty console and render the images Thumbnail in a new Kitty console.

[video telescope-media-file-external-kitty.webm](https://mgallegoa.github.io/telescope-media-files/telescope-media-file-external-kitty.webm)

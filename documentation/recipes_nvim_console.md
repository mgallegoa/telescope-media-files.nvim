# Recipe Nvim + Console

The internal nvim terminal don't support render images, in that case, the imagen Thumbnail is render using ASCII Art with chafa.

### Objetive:
Document the posibles configurations supported if the console can not render images (used ASSCII Art) or if the console can render images (example: kitty).

## Nvim + Console (don't support render images)

In this case the default configuration should work well, the default configuration use [Chafa](https://hpjansson.org/chafa/) to render ASCII Art support for consoles.

[video](https://mgallegoa.github.io/telescope-media-files/telescope-media-file.webm)


## Nvim + Kitty (support render images)

Kitty can render images in console, to allow render images in nvim console, you have to modify the TERM parameter to:

TERM=xterm-kitty

Now you can open a project in kitty console and render the images Thumbnail.

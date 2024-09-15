# Recipe Nvim + Tmux + Console

Objetive:
Document the posibles configurations supported with Tmux and a console able to render images, example: kitty.

## Nvim + Tmux + Kitty

This is allowed thanks to the Tmux ability to open new panes and use opend panes. In the new pane a console is open and render the Thumbnail (the console must have the ability to render images, for example kitty with kitten)

### Manage the pane to show the Thumbnail (tmux_index_pane_thumbnail)

The next video show how configured the plugin to show the Thumbnail in an specifict pane (https://mgallegoa.github.io/telescope-media-files/telescope-media-file-tmux-kitty-index-pane.webm)

<video width="640" height="360" controls>
  <source src="https://mgallegoa.github.io/telescope-media-files/telescope-media-file-tmux-kitty-index-pane.webm" type="video/webm">
  Your browser does not support the video tag.
</video>

This is allowed by configuring the tmux_index_pane_thumbnail in the setup for the telescope-media-files plugin.

You have to prepare the panes in your Tmux workspace and see the index pane that you want to show the image, Ctrl+b + s in Tmux to show the pane index.

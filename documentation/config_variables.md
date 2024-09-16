# Configuration variables

### filetypes
It is an object of the file types allowed to show in the telescope media files plugin. You can put the files allowed to override the default file type. 

Default: {"png", "jpg", "jpeg", "svg"} 

### find_cmd
If you have other find tool for search the files (default to fd), you can change it with this variable.

Default: "fd" 

### command_open_image
Using 'Ctrl+i' you open the image with an external tool, you can change it for example to "display" to show the image with a different external image viewer. Important this only apply to show the file in image format, you can open a pdf like an image with this option. 

Default: "eog"

### command_open_thumbnail 
If you want to open the Thumbnail with a tool different to ASCCI Art with chafa, you can use this variable to do it.

Important: the command should be in your path and should be supported by your console (for example if you used kitten, your console should support kitten to show the Thumbnail image)

Default: chafa custom command

### external_environment
Apply only for media_files_console.

This is to indicate the external environment to open the console. You can change it if you are using nvim+kitty (currently work in progress).

Default: "tmux"

### tmux_always_open_pane
Apply only for media_files_console.

This config variable indicate Tmux if always open a new pane/window to show the Thumbnail. The default behavior is to reuse the opened pane/window to show the Thumbnail (or open a new one if not exist), you can change it to 1 if you always want to open a new pane/window to show the Thumbnail.

Default: 0

### tmux_time_wait
Apply only for media_files_console.

This is to indicate Tmux if it is necessary to wait x seconds for the console render the image. Render image in console is a heavy task and consume machine resources, adjust this parameter for your environment help to show the image correctly.

Default: 0

### tmux_index_pane_thumbnail
Apply only for media_files_console.

With this parameter you can indicate to the telescope-media-file the index pane you want to see the Thumbnail image.

If you use this parameter equal or mayor to 0, you have to be sure that the pane exist and is not the same index where the nvim editor is opened. In Tmux use Ctrl+b+q to see the index pane.

Default: -1

### tmux_resize_open_pane
Apply only for media_files_console.

This config variable indicate the number of columns to adjust the opened pane. Apply only for new opened panes (be sure the variable tmux_always_open_pane is in 1)

Default: 0

## The next config variable are in work progress to add the kitty configuration WIP
### kitty_always_open_window
### kitty_time_wait
### kitty_index_window_thumbnail
### kitty_resize_open_window


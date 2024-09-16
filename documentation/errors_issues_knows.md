# Know error show from the telescope-media-files plugin

> 💡 **Tip:** Differentiate if you are using the default ASCCI Art method or the console methd. The telescope promp show the title 'Media Files' for default media files viewer and 'Media Files Console' for custom console Thumbnail viewer.

 > 💡 **Tip:** If using the console and don't see the image rendered, it could be becaus render the image take a while, you can configure a time to wait with the config variable tmux_time_wait (default to 0 seconds but you can put the number of seconds that your machine take to render the image)


### 'program' could not be found in your PATH.\n\nPlease install it to display font previews.
This message is for requisites not installed for the file type, see the ["Requisites" section] (https://github.com/mgallegoa/telescope-media-files.nvim/?tab=readme-ov-file#prerequisites)

To test, you can try in your console if the app is installed and working correctly, for example, use the command 'chafa --center=on --clear --colors=full -w 9 "my_input_path_image"'


Exit code: 127


### unknown file type path: 'file name'
This message is becaus the extension of the file is not supported, the list of the file supported are:
jpg | png | jpeg, svg | gif | avi | mp4 | wmv | dat | 3gp | ogv | mkv | mpg | mpeg | vob |  m2v | mov | webm | mts | m4v | rm  | qt | divx | pdf | epub | ttf | otf | woff | webp

Exit code: 128


### Can't convert the file, check if the file have a password, error: 'error_message'
This error if for convert file to image format (usually png), check the app to convert if it is working correctly.

To test, you can try in your console if the file converter is working correctly to png image, for example, use the command 'pdftoppm -png -singlefile "my_input_path_pdf" "my_output_path_image"'

Apps that show the message:
pdftoppm
fontpreview

Exit code: 129

### Tmux index pane configuration: The pane index configured 'tmux_index_pane_thumbnail', can not the same for the vim editor 'current_pane_index'.
Apply only for media_files_console.

This is because the config variable is set to a pane that is the same used for the nvim editor.

To show the index pane in Tmux user Ctrl+b+s and check the index pane number, change the config variable for the correct index (the Tmux index pane start in 0)

Exit code: 130




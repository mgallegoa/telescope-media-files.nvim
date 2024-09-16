#!/usr/bin/env bash

# In this bash file are the logic necessary to load the Thumbnails.
# Here can load thumbnails for pre-configured file types Example: jpg, pdf, ttf, mp4, gif, svg.
SCRIPT=`realpath $0`

readonly BASH_BINARY="$(which bash)"
declare -x PREVIEW_ID="preview"

declare -x TMP_FOLDER="$HOME/tmp/nvim-telescope-media"
mkdir -p $TMP_FOLDER

function render_at_size {
  if ! command -v chafa &> /dev/null; then
      printf "chafa could not be found in your PATH.\n\nPlease install it to display media content."
      exit 127
  fi

  img_path="${1}"
  max_width=${2}
  max_height=${3}
  file_name="${4}"
  command_thumbnail="${5}"
  clear
  eval "$command_thumbnail '$img_path'"

  if command -v file > /dev/null 2>&1; then
    file "${file_name}"
  fi
  exit 0
}

function svg {
  if ! command -v rsvg-convert &> /dev/null; then
    printf "rsvg-convert could not be found in your PATH.\n\nPlease install it to display media content."
    exit 127
  fi
  readonly converted_img_path="${TMP_FOLDER}/rsvg-convert.png"
  img_path="${1}"
  rsvg-convert "${img_path}" -o "${converted_img_path}"
  
  render_at_size "${converted_img_path}" "${2}" "${3}" "${img_path}" "${4}"
}
function videopreview {
  if ! command -v ffmpegthumbnailer &> /dev/null; then
    printf "ffmpegthumbnailer could not be found in your PATH.\n\nPlease install it to display video previews."
    exit 127
  fi
  readonly converted_img_path="${TMP_FOLDER}/ffmpegthumbnailer-convert.png"
  img_path="${1}"
  ffmpegthumbnailer -i "$img_path" -o "${converted_img_path}" -s 0 -q 10

  render_at_size "${converted_img_path}" "${2}" "${3}" "${img_path}" "${4}"

}
function pdfpreview {
  if ! command -v pdftoppm &> /dev/null; then
      printf "pdftoppm could not be found in your PATH.\n\nPlease install it to display pdf previews."
      exit 127
  fi
  readonly converted_pdf_img_path="${TMP_FOLDER}/pdftoppm-convert"
  img_path="${1}"
  error_message=$(pdftoppm -png -singlefile "${img_path}" "${converted_pdf_img_path}" 2>&1)
  if [ $? -ne 0 ]; then
    printf "Cann't convert the file, check if the file have a password, error: %s" "$error_message"
    exit
  fi
  render_at_size "${converted_pdf_img_path}.png" "${2}" "${3}" "${img_path}" "${4}"
}

function epubpreview {
  if ! command -v epub-thumbnailer &> /dev/null; then
      printf "epub-thumbnailer could not be found in your PATH.\n\nPlease install it to display epub previews."
     exit 127
  fi
  readonly converted_epub_img_path="${TMP_FOLDER}/epub-thumbnailer-convert.png"
  img_path="${1}"
  error_message=$(epub-thumbnailer "${img_path}" "${converted_epub_img_path}" 450 2>&1)
  if [ $? -ne 0 ]; then
    printf "Cann't convert the file, check if the file have a password, error: %s" "$error_message"
    exit 127
  fi
  render_at_size "${converted_epub_img_path}" "${2}" "${3}" "${img_path}" "${4}"
}

function fontimagepreview {
  if ! command -v fontpreview &> /dev/null; then
      printf "fontpreview could not be found in your PATH.\n\nPlease install it to display font previews."
     exit 127
  fi
  readonly converted_font_img_path="${TMP_FOLDER}/fontpreview-convert.png"
  img_path="${1}"
  error_message=$(fontpreview -i "${img_path}" -o "${converted_font_img_path}" 2>&1)
  if [ $? -ne 0 ]; then
    printf "Cann't convert the file, check if the file have a password, error: %s" "$error_message"
    exit
  fi
  render_at_size "${converted_font_img_path}" "${2}" "${3}" "${img_path}" "${4}"
}

function webp_image_preview {
  if ! command -v ffmpeg &> /dev/null; then
      printf "ffmpeg could not be found in your PATH.\n\nPlease install it to display font previews."
     exit 127
  fi
  readonly converted_webp_img_path="${TMP_FOLDER}/webp_preview-convert.png"
  img_path="${1}"
  printf "Strartint to convert"
  printf ${converted_webp_img_path}
  error_message=$(ffmpeg -y -i "${img_path}" "${converted_webp_img_path}" 2>&1)
  printf "end to convert, error: "$error_message
  if [ $? -ne 0 ]; then
    printf "Cann't convert the file, check if the file have a password, error: %s" "$error_message"
    exit
  fi
  render_at_size "${converted_webp_img_path}" "${2}" "${3}" "${img_path}" "${4}"
}

function parse_options {
    clear
    extension="${1##*.}"
    printf "Loading default preview...\nFile: ${1} \n"
    case $extension in
    jpg | png | jpeg)
        render_at_size "$1" $2 $3 "$1" "$4"
    ;;

    svg)
        svg "$1" $2 $3 "$4"
    ;;

    gif)
        render_at_size "$1" $2 $3 "$1" "$4"
    ;;

    avi | mp4 | wmv | dat | 3gp | ogv | mkv | mpg | mpeg | vob |  m2v | mov | webm | mts | m4v | rm  | qt | divx)
        videopreview "$1" $2 $3 "$4"
    ;;

    pdf)
        pdfpreview "$1" $2 $3 "$4"
    ;;

    epub)
        epubpreview "$1" $2 $3 "$4"
    ;;

    ttf | otf | woff)
        fontimagepreview "$1" $2 $3 "$4"
    ;;

    webp)
        webp_image_preview "$1" $2 $3 "$4"
    ;;


    *)
    printf "unknown file type path:\n$1"
    ;;
    esac
}

parse_options "${@}"
read

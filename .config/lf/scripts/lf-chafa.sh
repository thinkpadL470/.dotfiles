#!/bin/sh
# [VARIABLES]
  alias chafadisplay="chafa -f sixel -s "${2}x${3}" --animate off --polite on"
case "$(file -Lb --mime-type -- "$1")" in
  image/vnd.microsoft.icon) ffmpeg -i ${1} -f webp - | chafadisplay "-" ; exit 1 ;;
  image/*) chafadisplay "$1" ;;
  video/*) ffmpegthumbnailer -i "$1" -q 5 -s 0 -c jpg -o - | chafadisplay "-" ; exit 1 ;;
  *) cat "$1" ;;
esac

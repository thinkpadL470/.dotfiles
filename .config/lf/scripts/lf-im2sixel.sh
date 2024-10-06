#!/bin/sh
export lf_width_a=$(( ${lf_width} * 2 ))
case "$(file -Lb --mime-type -- "$1")" in
  image/*) img2sixel -w ${lf_width_a} -E fast -q low "${1}" ; exit 1 ;;
  video/*) ffmpegthumbnailer -i "$1" -q 5 -s 0 -c jpg -o - | img2sixel -w ${lf_width_a} -E fast -q low ; exit 1 ;;
  *) cat "${1}" ;;
esac

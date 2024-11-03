#!/bin/bash
# [ VARIABLES ]
  just_name_of_file=${1%%.*}
  exts_of_filename=${1#*.*.}
  only_video_ext=${exts_of_filename%%.*}
# [ EXEC ]
case "${@}" in
  [ -n "${1}" -a -n "${2}" ]) ffmpeg -y -hide_banner -loglevel "repeat+info" -i "$1" -i "$2" -c copy -map "0:v:0" -map "1:a:0" -movflags "+faststart" "${just_name_of_file}.${only_video_ext}"
  ;;
  )
  ;;
  *)
  ;;
esac



#!/bin/dash
# [Variables]
usrs=$(cat ~/.yt-dlp/tik-users)
# [Functions]
tikdl() {
  . ~/.local/share/pycvirtenv/tiklrenv/bin/activate && cd ~/.local/pythonscripts/tiklr &&
  python3 tiklr.py -mode automatic -user "${1}" -ffmpeg --auto-convert -output "/mnt/sm3-1-1/Videos/tiklivearc/" ;
};
trap "kill -- -$$" INT EXIT
# [EXEC]
for usr in ${usrs}; do
  tikdl ${usr} &
done ;
wait

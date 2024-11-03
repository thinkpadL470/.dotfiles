#!/bin/dash
trap "kill -- -$$" INT EXIT
# [ EXEC ]
  for usr in $(cat ~/.yt-dlp/tik_live_urls) ;
  do
    while true ;
    do
      . ~/.local/share/pycvirtenv/tiklrenv/bin/activate && cd ~/.local/pythonscripts/tiklr &&
      python3 tiklr.py -mode automatic -user "${usr}" -ffmpeg --auto-convert -output "/mnt/sm3-1-1/Videos/arctiklive/"
    done &
  done ;
  wait

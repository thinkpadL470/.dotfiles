#!/bin/dash
  trap "kill -- -$$" INT EXIT
# [ VARIABLES ]
  live_f='bv*[vcodec=vp9][height<=480][fps<=30]+mergeall[vcodec=none]/bv*[height<=480][fps<=30]+mergeall[vcodec=none]/bv*[vcodec=vp9][height<=720][fps<=30]+mergeall[vcodec=none]/bv*[height<=720][fps<=30]+mergeall[vcodec=none]/bv*[height<=480]+mergeall[vcodec=none]/bv*[height<=720]+mergeall[vcodec=none] / bv+mergeall[vcodec=none]/b'
  live_o_f='V-%(uploader)s__%(upload_date)s__%(id)s.%(ext)s'
# [ EXEC ]
  [ ! -d ~/Videos/yt-dlp/arcytlive ] && mkdir -p ~/Videos/yt-dlp/arcytlive
  for url in $(cat ~/.yt-dlp/yt_live_urls) ;
  do
    while true ;
    do
      cd ~/Videos/yt-dlp/arcytlive && 
      yt-dlp --audio-multistreams --fragment-retries 15 --file-access-retries 15 -R 50 -N 3 -c --no-download-archive --wait-for-video 900 --live-from-start -f "${live_f}" -o "${live_o_f}" "${url}"
    done &
  done ;
  wait

#!/usr/bin/dash
trap "kill -- -$$" INT EXIT
ytdlp_select_format=$(printf '%s%s%s%s%s%s%s' \
    'bv*[vcodec=vp9][height<=480][fps<=30]+mergeall[vcodec=none]/' \
    'bv*[height<=480][fps<=30]+mergeall[vcodec=none]/' \
    'bv*[vcodec=vp9][height<=720][fps<=30]+mergeall[vcodec=none]/' \
    'bv*[height<=720][fps<=30]+mergeall[vcodec=none]/' \
    'bv*[height<=480]+mergeall[vcodec=none]/' \
    'bv*[height<=720]+mergeall[vcodec=none] / ' \
    'bv+mergeall[vcodec=none]/b'
)
ytdlp_output_format='V-%(uploader)s__%(upload_date)s__%(id)s.%(ext)s'
[ ! -d ~/Videos/yt-dlp/arcytlive ] && mkdir -p ~/Videos/yt-dlp/arcytlive
for url in $(cat ~/.yt-dlp/yt_live_urls)
do
    while true
    do
        {
        cd ~/Videos/yt-dlp/arcytlive && 
        yt-dlp \
        --audio-multistreams \
        --fragment-retries 15 \
        --file-access-retries 15 \
        -R 50 -N 3 -c \
        --no-download-archive \
        --wait-for-video 900 \
        --live-from-start \
        -f "${ytdlp_select_format}" \
        -o "${ytdlp_output_format}" "${url}" ;
        }
    done &
done
wait

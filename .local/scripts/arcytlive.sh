#!/usr/bin/env dash
printf '%s\n' "$$" > "$UPID_DIR/arcytlive.pid"
cleanup () {
    rm $pids 2>/dev/null
}
die() { printf '%s: %s\n' "${shName}" "$*" >&2; exit 1; }
trap 'exit' INT TERM HUP QUIT
trap 'cleanup ; kill -- -$$' EXIT
shName=$(basename "$0")
pids="$UPID_DIR/arcytlive.pid"
arcDir="$HOME/Videos/yt-dlp/arcytlive"
ytdlSelectFormat=$(while IFS= read -r l ;
do
    printf '%s' "$l"
done <<'V_FORMAT'
bv*[vcodec=vp9][height<=480][fps<=30]+mergeall[vcodec=none]/
bv*[height<=480][fps<=30]+mergeall[vcodec=none]/
bv*[vcodec=vp9][height<=720][fps<=30]+mergeall[vcodec=none]/
bv*[height<=720][fps<=30]+mergeall[vcodec=none]/
bv*[height<=480]+mergeall[vcodec=none]/
bv*[height<=720]+mergeall[vcodec=none] / 
bv+mergeall[vcodec=none]/b
V_FORMAT
)
ytdlOutputFormat='V-%(uploader)s__%(upload_date)s__%(id)s.%(ext)s'

if [ ! -d "$arcDir" ] ; then
    if mkdir -p "$arcDir" ; then
        true
    else
        die "faild to create directory: $arcDir"
    fi
fi

while IFS= read -r url
do
    while true
    do
        cd "$arcDir" && 
        yt-dlp -R 50 -N 3 -c --fragment-retries 15 --file-access-retries 15 \
        --no-download-archive --no-cookies-from-browser \
        --force-overwrites \
        --audio-multistreams --live-from-start --wait-for-video "$(( 15 * 60 ))" \
        -f "${ytdlSelectFormat}" -o "${ytdlOutputFormat}" "${url}" &&
        sleep $(( 15 * 60 )) ;
    done &
done < "$HOME/.yt-dlp/yt_live_urls" 
wait

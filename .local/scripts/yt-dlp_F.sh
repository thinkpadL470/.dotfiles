#!/usr/bin/dash
url="${1}"
shift
printf '%s\t%s\t%-10s\t%s\n' "ID" "EXT" "RESOLUTION" "FPS"
yt-dlp -q -F "${url}" "${@}" 2>/dev/null >&1 |
    tr -s ' ' | cut -d ' ' -f '1-4' |
    sed 's/only//g ; /ID/d ; /-/d ; /mhtml/d' |
    awk '{printf "%s\t%s\t%-10s\t%s\n", $1, $2, $3, $4}' |
    sort -k2 -u | sort -n -k3

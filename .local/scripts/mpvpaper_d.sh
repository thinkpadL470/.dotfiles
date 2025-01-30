printf '%s' "$$" > /run/user/1000/mpvpaper_d.pid
trap ": > /run/user/1000/mpvpaper.pid ; : > /run/user/1000/mpvpaper_d.pid ; kill -- -$$" INT TERM QUIT KILL ABRT
mpvpaper -o \
    "no-config load-scripts=no aid=no loop-file=inf vo=libmpv panscan=1" \
    '*' \
    "${1}" & mpvpaperPID="$!"
printf '%s' "${mpvpaperPID}" > /run/user/1000/mpvpaper.pid ;
wait "$mpvpaperPID"

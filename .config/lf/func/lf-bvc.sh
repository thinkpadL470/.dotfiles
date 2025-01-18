# -- vars: wallpaper no ext, what is running?
lwp=~/.lbg.
pid_hyprpaper=$(ps -a -o "pid comm" | grep hyprpaper | tr -cd '0-9')
pid_mpvpaper=$(ps -a -o "pid comm" | grep mpvpaper | tr -cd '0-9')
# --

# -- set selected lf file as wallpaper file, kill running wallpaper services and run wallpaper service with opts
cp $f ${lwp}${f##*.}
[ -z "${pid_hyprpaper}" -a -z "${pid_mpvpaper}" ] ||
    kill -9 ${pid_hyprpaper} ${pid_mpvpaper} && {
    mpvpaper -o \
    "no-config load-scripts=no aid=no loop-file=inf vo=libmpv panscan=1" \
    '*' \
    "${lwp}${f##*.}" ;
}
# --

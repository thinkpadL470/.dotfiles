# -- vars: wallpaper no ext, what is running?, define hyprpaper conf, generate config
wp=~/.bg.
pid_hyprpaper=$(ps -a -o "pid comm" | grep hyprpaper | tr -cd '0-9')
pid_mpvpaper=$(ps -a -o "pid comm" | grep mpvpaper | tr -cd '0-9')
hyprpapc=${HOME}/.config/hypr/hyprpaper.conf
genconfig=$({ printf '%s\n%s\n%s\n' \
    "preload = ${wp}${f##*.}" \
    "wallpaper = HDMI-A-1,${wp}${f##*.}" \
    "splash = false" ;
})
# --

# -- set selected lf file as wallpaper file and kill running wallpaper services and run wallpaper service
${HOME}/.config/lf/func/flushwp.sh
cp $f ${wp}${f##*.}
[ -z "${pid_hyprpaper}" -a -z "${pid_mpvpaper}" ] ||
    kill -9 ${pid_hyprpaper} ${pid_mpvpaper} && {
    printf '%s\n' "${genconfig}" > ${hyprpapc} ;
    hyprpaper ;
}
# --

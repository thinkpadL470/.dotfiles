#!/usr/bin/dash
. ${HOME}/.local/func/define_script_directories_in_variables.sh

# -- vars: wallpaper no ext, what is running?, define hyprpaper conf, generate config

    # -- check if file is a video and set application
    cat ~/.config/mime/video.txt | grep -x "${f##*.}" && wp_application='mpvpaper'
    cat ~/.config/mime/image.txt | grep -x "${f##*.}" && wp_application='hyprpaper'
    # --
wp=~/.bg.
pid_hyprpaper=$(ps -a -o "pid comm" | grep hyprpaper | tr -cd '0-9')
pid_mpvpaper=$(ps -a -o "pid comm" | grep mpvpaper | tr -cd '0-9')
[ ${wp_application} = 'hyprpaper' ] && {
    hyprpapc=${HOME}/.config/hypr/hyprpaper.conf ;
    genconfig=$({ printf '%s\n%s\n%s\n' \
        "preload = ${wp}${f##*.}" \
        "wallpaper = , ${wp}${f##*.}" \
        "splash = false" ;
    }) ;
}
# --

# -- set selected lf file as wallpaper file and kill running wallpaper services and run wallpaper service
${fu_d}/flushwp.sh
cp $f ${wp}${f##*.}
[ -z "${pid_hyprpaper}" -a -z "${pid_mpvpaper}" ] ||
    kill -9 ${pid_hyprpaper} ${pid_mpvpaper} && {
    [ "${wp_application}" = 'hyprpaper' ] && {
        printf '%s\n' "${genconfig}" > ${hyprpapc} ;
        hyprpaper ;
    };
    [ "${wp_application}" = 'mpvpaper' ] && {
        mpvpaper -o \
        "no-config load-scripts=no aid=no loop-file=inf vo=libmpv panscan=1" \
        '*' \
        "${wp}${f##*.}" ;
    };
}
# --

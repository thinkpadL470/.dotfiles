#!/usr/bin/env dash
. ${HOME}/.local/func/define_script_directories_in_variables.sh
# -- vars: wallpaper no ext, what is running?, define hyprpaper conf, generate config
wp=~/.bg.

    # -- check if file is a video and set application
    cat ~/.config/mime/video.txt | grep -x "${f##*.}" && wp_application='mpvpaper'
    cat ~/.config/mime/image.txt | grep -x "${f##*.}" && wp_application='hyprpaper'
    # --
[ "${wp_application}" = "hyprpaper" ] && {
    hyprpc=${HOME}/.config/hypr/hyprpaper.conf ;
    genconfig=$({ printf '%s\n%s\n%s\n' \
        "preload = ${wp}${f##*.}" \
        "wallpaper = , ${wp}${f##*.}" \
        "splash = false" ;
    });
}
# --

# -- set selected lf file as wallpaper file and kill running wallpaper services 
. ${fu_d}/flushwp.sh
cp $f ${wp}${f##*.}
[ -s "${UPID_DIR}/hyprpaper_d.pid" ] &&
    kill -15 $(cat ${UPID_DIR}/hyprpaper_d.pid) || true
[ -s "${UPID_DIR}/mpvpaper_d.pid" ] &&
    kill -15 $(cat ${UPID_DIR}/mpvpaper_d.pid) || true
# --

# -- run wallpaper service
[ "${wp_application}" = 'hyprpaper' ] && {
    printf '%s\n' "${genconfig}" > ${hyprpc} ;
    setpgid dash ${hyprsh}/hyprpaper_d.sh & exit 0
}
[ "${wp_application}" = 'mpvpaper' ] && {
    setpgid dash ${sh_d}/mpvpaper_d.sh "${wp}${f##*.}" & exit 0
}
# --

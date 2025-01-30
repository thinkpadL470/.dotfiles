#!/usr/bin/env bash
. ${HOME}/.local/func/define_script_directories_in_variables.sh
hyprpapsh="${HOME}/.config/hypr/scripts"
# -- vars: wallpaper no ext, what is running?, define hyprpaper conf, generate config
wp=~/.bg.

    # -- check if file is a video and set application
    cat ~/.config/mime/video.txt | grep -x "${f##*.}" && wp_application='mpvpaper'
    cat ~/.config/mime/image.txt | grep -x "${f##*.}" && wp_application='hyprpaper'
    # --
[ "${wp_application}" = "hyprpaper" ] && {
    hyprpapc=${HOME}/.config/hypr/hyprpaper.conf ;
    genconfig=$({ printf '%s\n%s\n%s\n' \
        "preload = ${wp}${f##*.}" \
        "wallpaper = , ${wp}${f##*.}" \
        "splash = false" ;
    });
}
# --

# -- set selected lf file as wallpaper file and kill running wallpaper services and run wallpaper service
. ${fu_d}/flushwp.sh
cp $f ${wp}${f##*.}
[ -s "/run/user/1000/hyprpaper_d.pid" ] &&
    kill -15 $(cat /run/user/1000/hyprpaper_d.pid) || true
[ -s "/run/user/1000/mpvpaper_d.pid" ] &&
    kill -15 $(cat /run/user/1000/mpvpaper_d.pid) || true
[ "${wp_application}" = 'hyprpaper' ] && {
    printf '%s\n' "${genconfig}" > ${hyprpapc} ;
    ${hyprpapsh}/hyprpaper_d.sh ;
}
[ "${wp_application}" = 'mpvpaper' ] && {
    ${sh_d}/mpvpaper_d.sh "${wp}${f##*.}" ;
}
# --

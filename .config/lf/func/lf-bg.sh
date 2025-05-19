#!/usr/bin/env dash
# --
flush_wp () {
local tra_dir="${HOME}/.local/share/graveyard" ;
[ ! -d "${tra_dir}" ] && mkdir -p ${tra_dir} ;
ls -1 ${HOME}/.bg.* |
    while IFS= read -r wpfile
    do
        wpfilep=${wpfile%/*}
        mkdir -p ${tra_dir}/${wpfilep}
        mv ${wpfile} ${tra_dir}/${wpfilep}$(date +%y-%b-%d-%H-%M-%S)${wpfile##*/}
    done ;
    return 0 ;
}
# --

# --
kill_paper_services () {
    [ -s "${UPID_DIR}/mpvpaper_d.pid" ] && {
        until [ -z "${UPID_DIR}/mpvpaper_d.pid" ]
        do
            kill -TERM $(cat ${UPID_DIR}/mpvpaper_d.pid) ;
    [ -s "${UPID_DIR}/hyprpaper_d.pid" ] &&
        kill -TERM $(cat ${UPID_DIR}/hyprpaper_d.pid) ;
    return 0 ;
}
# --

# -- vars: wallpaper no ext, what is running?, define hyprpaper conf, generate config
wp=~/.bg.

    # -- check if file is a video and set application
    cat ~/.config/mime/video.txt | grep -x "${f##*.}" && wp_application='mpvpaper'
    cat ~/.config/mime/image.txt | grep -x "${f##*.}" && wp_application='hyprpaper'
    # --
sh_d="${HOME}/.local/scripts"
[ "${wp_application}" = "hyprpaper" ] && {
    hyprsh="${HOME}/.config/hypr/scripts"
    hyprpc=${HOME}/.config/hypr/hyprpaper.conf ;
    genconfig=$({ printf '%s\n%s\n%s\n' \
        "preload = ${wp}${f##*.}" \
        "wallpaper = , ${wp}${f##*.}" \
        "splash = false" ;
    });
}
# --

# -- set selected lf file as wallpaper file and kill running wallpaper services 
flush_wp
cp $f ${wp}${f##*.}
kill_paper_services
# --

# -- run wallpaper service
[ "${wp_application}" = 'hyprpaper' ] && {
    printf '%s\n' "${genconfig}" > ${hyprpc} ;
    setpgid dash ${hyprsh}/hyprpaper_d.sh & exit ;
}
[ "${wp_application}" = 'mpvpaper' ] && {
    setpgid dash ${sh_d}/mpvpaper_d.sh "${wp}${f##*.}" & exit ;
}
# --

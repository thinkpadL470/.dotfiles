#!/usr/bin/env dash
# -- look for wallpaper in home dir
current_wp=$(ls -1 .bg.* | head -n1)
wpext=${current_wp##*.}
# --

# --
mkdir_folders_inseq () {
    local first_dir="${1}" ;
    local end_dir="${2}/" ;
    local dir_seqence=$({
        until [ "${first_dir}" = "${end_dir}" ]
        do
            end_dir="${end_dir%/*}"
            printf '%s\n' "${end_dir}"
        done | sort ;
    }) ;
    {
        printf '%s\n' "${dir_seqence}" |
        while IFS= read item ; do mkdir -m 700 ${item} ; done ;
    } 2>/dev/null ;
    [ -d "${end_dir}" ] && return 0 || return 1 ;
}
# --

# -- save the wallpaper
[ -n "${wpext}" ] && {
    { [ ! -d "${HOME}/Pictures/wallpapers" ] &&
        mkdir_folders_inseq "${HOME}/Pictures" "${HOME}/Pictures/wallpapers" ;
    };
    cp ${HOME}/.bg.${wpext} ${HOME}/Pictures/wallpapers/WP-$(date +%y-%b-%d-%H-%M-%S).${wpext} &&
        { notify-send -t 2000 "hyprwhsave" 'wallpaper saved' && exit 0 ; } ||
            { notify-send -t 2000 "hyprwhsave" 'wallpaper faild saveing' && exit 0 ; }
} || {
    notify-send -t 2000 "hyprwhsave" 'no applicable wallpaper exists' ;
    exit 1 ;
}
# --

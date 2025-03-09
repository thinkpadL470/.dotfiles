gen_hyprp_conf () {
    printf '%s\n%s\n%s\n' \
        "preload = ${wp} " \
        "wallpaper = , ${wp} " \
        "splash = false" ;
    return 0 ;
}

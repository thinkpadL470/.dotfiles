check__clip_copy () {
    wl_copy_bin_path=$(realpath /usr/bin/wl-copy) || {
        wl_copy_bin_path=$(type wl-copy) && wl_copy_bin_path=$(realpath ${wl_copy_bin_path##* }) ;
    };
    [ -x "${wl_copy_bin_path}" ] &&
        cbc="${wl_copy_bin_path}" ;
    [ -x /data/data/com.termux/files/usr/bin/termux-clipboard-set ] &&
        cbc="/data/data/com.termux/files/usr/bin/termux-clipboard-set" ;
}

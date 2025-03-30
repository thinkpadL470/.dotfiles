get_fsrc_dir_realpath () {
    local pattern=${1} ;
    realpath $({
        { find ~/../../ -iname "${pattern}" ;
        } 2>/dev/null |
        sort |
        head -n1 ;
    });
    return 0 ;
}

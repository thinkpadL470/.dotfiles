get_fsrc_base_path () {
    local item=${1} ;
    local full_item=$(cd $(dirname ${item}) && pwd)/$(basename "${item}") ;
    [ -d /home ] && {
        printf '%s\n' "${full_item}" | cut -d '/' -f '1-3' ;
    } ;
    [ -d /data/data/com.termux/files/home ] && {
        printf '%s\n' "${full_item}" | cut -d '/' -f '1-6' ;
    } ; 
}

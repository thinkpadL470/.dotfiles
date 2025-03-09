flush_wp () {
local tra_dir="${HOME}/.local/share/graveyard" ;
[ ! -d "${tra_dir}" ] && mkdir -p ${tra_dir} ;
ls -1 ${HOME}/.bg.* |
    while IFS= read -r wpfile
    do
        mv ${wpfile} ${tra_dir}/${wpfile}$(date +%y-%b-%d-%H-%M-%S)
    done ;
    return 0 ;
}

${HOME}/.local/func/define_script_directories_in_variables.sh
tra_dir="${HOME}/.local/share/graveyard/home"
[ ! -d "${tra_dir}" ] && mkdir ${tra_dir}
{ cd ${HOME} && ls .bg.* |
    while IFS= read -r wpfile
    do
        cd ${HOME}
        mv ${wpfile} ${tra_dir}/${wpfile}$(${fu_d}/suffix_date.sh secs)
    done ;
}

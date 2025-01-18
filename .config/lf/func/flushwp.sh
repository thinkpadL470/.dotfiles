. ${HOME}/.local/func/define_script_directories_in_variables.sh

# -- the dir to trash files to, if no dir create it
tra_dir="${HOME}/.local/share/graveyard/home"
[ ! -d "${tra_dir}" ] && mkdir -p ${tra_dir}
# --

# -- trash the wallpapers
cd ${HOME} && ls -1 .bg.* |
    while IFS= read -r wpfile
    do
        cd ${HOME}
        mv ${wpfile} ${tra_dir}/${wpfile}$(${fu_d}/suffix_date.sh secs)
    done ;
# --

#!/usr/bin/env dash
# -- the dir to trash files to, if no dir create it
tra_dir="${HOME}/.local/share/graveyard"
[ ! -d "${tra_dir}" ] && mkdir -p ${tra_dir}
# --

# -- trash the wallpapers
ls -1 ${HOME}/.bg.* |
    while IFS= read -r wpfile
    do
        mv ${wpfile} ${tra_dir}/${wpfile}$(${fu_d}/suffix_date.sh secs)
    done ;
# --

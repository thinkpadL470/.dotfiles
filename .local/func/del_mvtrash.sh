case "${trashpwd}" in
    ${HOME})
        [ ! -d "${HOME}/.local/share/graveyard/mvtrash" ] &&
            mkdir -p ${HOME}/.local/share/graveyard/mvtrash
        {
            tra_path="${HOME}/.local/share/graveyard/mvtrash" ;
            for item in "${@}"
            do
                [ "$USER" = "root" ] && {
                    mv "${item}" "${tra_path}/${item##*/}$(${fu_d}/suffix_date.sh nanosecs)" ||
                    mv "${item}" "${tra_path}/${item}$(${fu_d}/suffix_date.sh nanosecs)" ;
                }
            done ;
        }
        ;;
    /mnt/*)
        [ ! -d "${trashpwd}/graveyard-${USER}/mvtrash-${USER}" ] &&
            mkdir -p ${trashpwd}/graveyard-${USER}/mvtrash-${USER}
        {
            tra_path="${trashpwd}/graveyard-${USER}/mvtrash-${USER}" ;
            for item in "${@}"
            do
                [ "$USER" = "root" ] && {
                    mv "${item}" "${tra_path}/${item##*/}$(${fu_d}/suffix_date.sh nanosecs)" ||
                    mv "${item}" "${tra_path}/${item}$(${fu_d}/suffix_date.sh nanosecs)" ;
                }
            done ;
        }
        ;;
    !(/mnt))
        [ ! -d "/tmp/graveyard-${USER}/mvtrash-${USER}" ] &&
            mkdir -p /tmp/graveyard-${USER}/mvtrash-${USER}
        ${fu_d}/for_files_trash_to_root.sh "${@}"
        ;;
    *)
        [ ! -d "/tmp/graveyard-${USER}/mvtrash-${USER}" ] &&
            mkdir -p /tmp/graveyard-${USER}/mvtrash-${USER}
        ${fu_d}/for_files_trash_to_root.sh "${@}"
        ;;
esac

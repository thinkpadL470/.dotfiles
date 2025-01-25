# -- move to graveyard
case "${branchpwd}" in

    # -- in the case of branch pwd is inside users home trash to users graveyard
    ${HOME})
        [ ! -d "${HOME}/.local/share/graveyard/mvtrash" ] &&
            mkdir -p ${HOME}/.local/share/graveyard/mvtrash
        { tra_path="${HOME}/.local/share/graveyard/mvtrash" ;
            for item in "${@}"
            do
                    mv "${item}" "${tra_path}/${item##*/}$(${fu_d}/suffix_date.sh nanosecs)" ||
                    mv "${item}" "${tra_path}/${item}$(${fu_d}/suffix_date.sh nanosecs)" ;
            done ;
        }
        ;;
    # --

    # -- if in a mnt/ dir trash to users graveyard in mnt dir
    /mnt/*)
        [ ! -d "${branchpwd}/graveyard-${USER}/mvtrash-${USER}" ] &&
            mkdir -p ${branchpwd}/graveyard-${USER}/mvtrash-${USER}
        { tra_path="${branchpwd}/graveyard-${USER}/mvtrash-${USER}" ;
            for item in "${@}"
            do
                    mv "${item}" "${tra_path}/${item##*/}$(${fu_d}/suffix_date.sh nanosecs)" ||
                    mv "${item}" "${tra_path}/${item}$(${fu_d}/suffix_date.sh nanosecs)" ;
            done ;
        }
        ;;
    # --

    # -- if branchpwd not in user home or a mnt/ dir trash to users system graveyard
    !(/mnt))
        [ ! -d "/tmp/graveyard-${USER}/mvtrash-${USER}" ] &&
            mkdir -p /tmp/graveyard-${USER}/mvtrash-${USER}
        {
            tra_path="/tmp/graveyard-${USER}/mvtrash-${USER}"
            for item in "${@}"
            do
                    mv "${item}" "${tra_path}/${item##*/}$(${fu_d}/suffix_date.sh nanosecs)" ||
                    mv "${item}" "${tra_path}/${item}$(${fu_d}/suffix_date.sh nanosecs)" ;
            done ;
        }
        ;;
    # --

    # -- use user system graveyard in all other cases
    *)
        [ ! -d "/tmp/graveyard-${USER}/mvtrash-${USER}" ] &&
            mkdir -p /tmp/graveyard-${USER}/mvtrash-${USER}
        {
            tra_path="/tmp/graveyard-${USER}/mvtrash-${USER}"
            for item in "${@}"
            do
                    mv "${item}" "${tra_path}/${item##*/}$(${fu_d}/suffix_date.sh nanosecs)" ||
                    mv "${item}" "${tra_path}/${item}$(${fu_d}/suffix_date.sh nanosecs)" ;
            done ;
        }
        ;;
    # --
esac

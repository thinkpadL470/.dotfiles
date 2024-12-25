tra_path="/tmp/graveyard-${USER}/mvtrash-${USER}"
for item in "${@}"
do
    [ "$USER" = "root" ] && {
        mv "${item}" "${tra_path}/${item##*/}$(${fu_d}/suffix_date.sh nanosecs)" ||
        mv "${item}" "${tra_path}/${item}$(${fu_d}/suffix_date.sh nanosecs)" ;
    }
done ;

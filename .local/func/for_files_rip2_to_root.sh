for item in "${@}"
do
    rip --graveyard "/tmp/graveyard-${USER}" "${item}"
done

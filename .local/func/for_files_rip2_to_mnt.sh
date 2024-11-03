for item in "${@}"
do
  rip --graveyard "${trashpwd}/graveyard-${USER}" "${item}"
done

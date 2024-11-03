  for item in "${@}"
  do
    mv "${item}" "${trashpwd}/graveyard-${USER}/mvtrash-${USER}/${item}$(~/.local/func/suffix_date.sh nanosecs)"
  done

for item in "${@}"
do
  mv "${item}" "${HOME}/.local/share/graveyard/mvtrash/${item}$(~/.local/func/suffix_date.sh nanosecs)"
done

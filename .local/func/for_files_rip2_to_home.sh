for item in "${@}"
do
  rip --graveyard "${HOME}/.local/share/graveyard" "${item}"
done

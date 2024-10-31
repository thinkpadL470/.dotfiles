#!/bin/bash
shopt -s extglob
trashpwd=$(printf "${PWD}\n" | cut -d '/' -f '1,2,3')
homedelfiles () {
  for item in "${@}"
  do
    rip --graveyard "${HOME}/.local/share/graveyard" ${item}
  done
};
mntdelfiles () {
  for item in "${@}"
  do
    rip --graveyard "${trashpwd}/graveyard-${USER}" ${item}
  done
};
rootdelfiles () {
  for item in "${@}"
  do
    rip --graveyard "/tmp/graveyard-${USER}" ${item}
  done
}
case "${trashpwd}" in
  ${HOME}) [ ! -d "${HOME}/.local/share/graveyard" ] &&
    mkdir -p ${HOME}/.local/share/graveyard
    homedelfiles ${@}
  ;;
  /mnt/*) [ ! -d "${trashpwd}/graveyard-${USER}" ] &&
    mkdir -p ${trashpwd}/graveyard-${USER}
    mntdelfiles ${@}
  ;;
  !(/mnt)) [ ! -d "/tmp/graveyard-${USER}" ] &&
    mkdir -p /tmp/graveyard-${USER}
    rootdelfiles ${@}
  ;;
  *) [ ! -d "/tmp/graveyard-${USER}" ] &&
    mkdir -p /tmp/graveyard-${USER}
    rootdelfiles ${@}
  ;;
esac
printf 'bazinga\n'

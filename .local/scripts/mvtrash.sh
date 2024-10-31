#!/bin/bash
shopt -s extglob
trashpwd=$(printf "${PWD}\n" | cut -d '/' -f '1,2,3')
homedelfiles () {
  for item in "${@}"
  do
    mv ${item} ${HOME}/.local/share/graveyard/mvtrash/${item}$(date +%y-%b-%d-%H-%M-%S-%6N)
  done
};
mntdelfiles () {
  for item in "${@}"
  do
    mv ${item} ${trashpwd}/graveyard-${USER}/mvtrash-${USER}/${item}$(date +%y-%b-%d-%H-%M-%S-%6N)
  done
};
rootdelfiles () {
  for item in "${@}"
  do
    mv ${item} /tmp/graveyard-${USER}/mvtrash-${USER}/${item}$(date +%y-%b-%d-%H-%M-%S-%6N)
  done
}
case "${trashpwd}" in
  ${HOME}) [ ! -d "${HOME}/.local/share/graveyard/mvtrash" ] &&
    mkdir -p ${HOME}/.local/share/graveyard/mvtrash
    homedelfiles ${@}
  ;;
  /mnt/*) [ ! -d "${trashpwd}/graveyard-${USER}/mvtrash-${USER}" ] &&
    mkdir -p ${trashpwd}/graveyard-${USER}/mvtrash-${USER}
    mntdelfiles ${@}
  ;;
  !(/mnt)) [ ! -d "/tmp/graveyard-${USER}/mvtrash-${USER}" ] &&
    mkdir -p /tmp/graveyard-${USER}/mvtrash-${USER}
    rootdelfiles ${@}
  ;;
  *) [ ! -d "/tmp/graveyard-${USER}/mvtrash-${USER}" ] &&
    mkdir -p /tmp/graveyard-${USER}/mvtrash-${USER}
    rootdelfiles ${@}
  ;;
esac
printf 'bazinga\n'

#!/bin/bash
pipxpkgs () {
  pipx list | grep package | sed 's/\ \ \ //g' | cut -d ' ' -f '2'
};
cargopkgs () {
  cargo install --list | grep : | cut -d ' ' -f '1'
};
pacmanup () {
  pacman -Syyu --config "${PACMCONF}" &&
    [ -d ~/.config/pacman ] &&
      pacman -Qqe > ~/.config/pacman/pkglist.txt &&
      pacman -Qqm > ~/.config/pacman/pkglist_m.txt
}

[ -x /bin/doas ] && [ ! -x /bin/sudo ] && auth=doas
[ ! -x /bin/doas ) && [ -x /bin/sudo ] && auth=sudo
[ "${auth}" = doas ] && ${auth} pacmanup
[ "${auth}" = sudo ] && ${auth} pacmanup

[ ! -x /bin/pipx ] &&
  ${auth} pacman -S python-pipx
[ -x /bin/pipx ] &&
  [ ! -d ~/.config/pipx ] && mkdir ~/.config/pipx
  [ -x /usr/bin/pipx -a -d ~/.config/pipx ] &&
    pipx upgrade-all --skip fabric &&
    pipxpkgs > ~/.config/pipx/pipxpkgslist.txt

[ ! -x /bin/cargo -o -x /bin/rustup ] &&
  curl https://sh.rustup.rs -sSf | sh &&
  cargo install-update

[ -x /usr/bin/cargo -a -x "$HOME/.cargo/bin/cargo-install-update" ] &&
  rustup update &&
  cargo install-update -a &&
  cargopkgs > ~/.cargo/cargopkgslist.txt

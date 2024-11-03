#!/bin/sh
pwdvar=$(pwd)
cd ~/.local/func

[ -x /bin/doas ] && [ ! -x /bin/sudo ] && auth=doas
[ ! -x /bin/doas ] && [ -x /bin/sudo ] && auth=sudo

sleep 2
echo 'updating pacman'
sleep 2

[ -n "${auth}" ] &&
  . ./sys_update_pacman.sh

sleep 2 && echo 'done updating pacman'
sleep 1 && echo 'installing/updating pipx'
sleep 2

[ ! -x /bin/pipx ] &&
  ${auth} pacman -S python-pipx
[ -x /bin/pipx ] &&
  . ./sys_update_pipx.sh

sleep 2 && echo 'done updating pipx'
sleep 1 && echo 'installing/updating rust/cargo' 
sleep 2

[ ! -x /bin/cargo ] && [ ! -x /bin/rustup ] &&
  curl https://sh.rustup.rs -sSf | sh

[ -x /usr/bin/cargo -a -x "$HOME/.cargo/bin/cargo-install-update" ] &&
  [ ! -d ~/.cargo ] && mkdir -p ~/.cargo
  . ./sys_update_cargo.sh

cd "${pwdvar}"

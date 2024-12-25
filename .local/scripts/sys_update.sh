#!/bin/sh
pwdvar=$(pwd)
cd ${HOME}/.local/func

[ -x /bin/doas ] && [ ! -x /bin/sudo ] && auth=doas
[ ! -x /bin/doas ] && [ -x /bin/sudo ] && auth=sudo

[ -n "${auth}" ] &&
	. ./sys_update_pacman.sh

[ ! -x /bin/pipx ] &&
	${auth} pacman -S python-pipx
[ -x /bin/pipx ] &&
	. ./sys_update_pipx.sh

[ ! -x /bin/cargo ] && [ ! -x /bin/rustup ] &&
	curl https://sh.rustup.rs -sSf | sh

[ -x /usr/bin/cargo -a -x "${HOME}/.cargo/bin/cargo-install-update" ] &&
	[ ! -d ${HOME}/.cargo ] && mkdir -p ${HOME}/.cargo
	. ./sys_update_cargo.sh

cd "${pwdvar}"

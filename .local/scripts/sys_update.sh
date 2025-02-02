#!/usr/bin/env dash
. ~/.local/func/define_script_directories_in_variables.sh
. ${fu_d}/check_auth.sh
[ -n "${auth}" ] &&
    . ${fu_d}/sys_update_pacman.sh
[ ! -x /bin/pipx ] && [ -n "${auth}" ] &&
    ${auth} pacman -S python-pipx
[ -x /usr/bin/pipx ] &&
    . ${fu_d}/sys_update_pipx.sh
[ ! -x /usr/bin/cargo ] && [ ! -x /bin/rustup ] &&
    curl https://sh.rustup.rs -sSf | sh
[ -x /usr/bin/cargo -a -x "${HOME}/.cargo/bin/cargo-install-update" ] &&
    [ ! -d ${HOME}/.cargo ] && mkdir -p ${HOME}/.cargo
    . ${fu_d}/sys_update_cargo.sh

#!/bin/bash
[ -d ~/.local/func ] && cd ~/.local/func || exit 0
. ./substitute_env_in_pacman_conf.sh
. ./substitute_env_in_tofi.sh

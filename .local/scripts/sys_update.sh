#!/usr/bin/env dash
set -eu
shName=$(basename "$0")

die() { printf '%s: %s\n' "$shName" "$@" >&2 ; exit 1; }
msg() { printf '%s\n' "$@" ; }

require_cmds() {
    while [ "$#" -gt 0 ] ;
    do
        command -v "$1" >/dev/null 2>&1 || die "missing required binary: $1"
        shift
    done
}

auth_cmd() {
    [ -d /data/data/com.termux/files/home ] && { printf '%s' ''; return 0; }
    _found=''
    set -- sudo doas
    while [ "$#" -gt 0 ] ;
    do
        command -v "$1" >/dev/null 2>&1 && {
            [ -n "$_found" ] && {
                die "Both sudo and doas found; please keep exactly one" ;
            } ;
            _found=$(command -v "$1") ;
        }
        shift
    done
    [ -n "$_found" ] || die "Neither sudo nor doas found; install one"
    printf '%s' "$_found"
}

run_priv() {
    _a=$(auth_cmd)
    if [ -n "$_a" ]; then
        "$_a" "$@"
    else
        "$@"
    fi
}

update_pacman () {
    _confPacman="$HOME/.config/pacman/pacman.conf"
    [ ! -d "${_confPacman%/*}" ] && mkdir "${_confPacman%/*}"
    if [ -f "$_confPacman" ] ; then
        msg "updating with pacman conf"
        run_priv pacman -Syyu --config "${_confPacman}"
    elif [ ! -f "$_confPacman" ] ; then
        msg "updating without pacman conf"
        run_priv pacman -Syyu
    else
        die "updating system with and without config failed"
    fi &&
        if {
            _eFile="${_confPacman%/*}/pac-PL-arch.txt"
            _mFile="${_confPacman%/*}/pac-PL-m-arch.txt"
            pacman -Qqe > "$_eFile" &&
            pacman -Qqm > "$_mFile" ;
        } then
            msg "updated system and saved packagelists to: ${_confPacman%/*}"
        else
            die "failed to append package lists to"
        fi
}

update_pipx () {
    _confDirPipx="$HOME/.config/pipx"
    [ ! -d "$_confDirPipx" ] && mkdir "$_confDirPipx"
    if [ -d "$_confDirPipx" ] ; then
        if pipx upgrade-all ; then
            _pipxFile="$HOME/.config/pipx/pipx_PL.txt"
            if { pipx list | grep package | cut -d ' ' -f '5' > "$_pipxFile" ;
            } ; then
                msg "appended package list to: $_confDirPipx"
            else
                msg "failed to append package list to: $_confDirPipx"
            fi
        else
            die "failed to upgrade pipx Packages"
        fi
    else
        die "failed to create pipx config dir: $_confDirPipx"
    fi
}

require_cmds pipx pacman
update_pacman
update_pipx

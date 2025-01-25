#!/usr/bin/env sh
set -eu

# -- catch arguments
[ ${#} -eq 0 ] && {
    printf "%s\n" "readlinkf: no file path provided" ;
    exit 0 ;
}
[ "${1:-}" ] || return 1
# --

# -- to avoid changing to an unexpected directory
max_symlinks=40
CDPATH=''
target=${1}
# --

# -- trim trailing slashes
[ -e "${target%/}" ] || target=${1%"${1##*[!/]}"}
[ -d "${target:-/}" ] && target="${target}/"
# --

# -- print file path
cd -P . 2>/dev/null || return 1
while [ "$max_symlinks" -ge 0 ] && max_symlinks=$((max_symlinks - 1))
do
    [ ! "$target" = "${target%/*}" ] && {
        case $target in
            /*) cd -P "${target%/*}/" 2>/dev/null || break
                ;;
            *) cd -P "./${target%/*}" 2>/dev/null || break
                ;;
        esac ;
        target=${target##*/} ;
    }
    [ ! -L "$target" ] && {
        target="${PWD%/}${target:+/}${target}" ;
        printf '%s\n' "${target:-/}" ;
        exit 0 ;
    }
    link=$(ls -dl -- "$target" 2>/dev/null) || break
    target=${link#*" $target -> "}
done
# --

exit 1

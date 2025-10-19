#!/usr/bin/env bash
set -eu
shName="$(basename "${0}")"
roots="/mnt"

die() { printf '%s: %s\n' "${shName}" "$*" >&2; exit 1; }

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
            [ -n "${_found}" ] && {
                die "Both sudo and doas found; please keep exactly one" ;
            } ;
            _found=$(command -v "$1") ;
        }
        shift
    done
    [ -n "${_found}" ] || die "Neither sudo nor doas found; install one"
    printf '%s' "${_found}"
}

run_priv() {
    _a=$(auth_cmd)
    if [ -n "$_a" ]; then
        "$_a" "$@"
    else
        "$@"
    fi
}

require_cmds find pacman paccache
fd=0
command -v fd >/dev/null 2>&1 && fd=1

cleaningListFile="${HOME}/.config/find/cleaning_list"

[ "${1-}" = "--CleanFolders" ] && [ -f "${cleaningListFile}" ] &&
    {
        findPru=$(tr '\n' ' ' < "${HOME}/.config/find/pruned")
        while IFS= read -r line ;
        do
            [ -z "${line}" ] && continue
            case "${line}" in \#*) continue ;; esac
                time="${line%% *}"
                dirName="${line##* }"
                foundDirs=''
                for root in ${roots} ;
                do
                    set -f
                    dirsThisRoot=$(run_priv \
                        find -L "${root}" ! \( $findPru \) \
                        -type d -name "${dirName}" -print 2>/dev/null || true
                    )
                    set +f
                    [ -n "${dirsThisRoot}" ] && foundDirs=$(printf \
                        '%s\n%s\n' "${foundDirs}" "${dirsThisRoot}"
                    )
                done
                [ -n "${foundDirs}" ] && continue
                { [ "${fd}" -eq 1 ] &&
                    while IFS= read -r tDir ;
                    do
                        [ -z "${tDir}" ] && continue
                        fd -a -t f --changed-before "${time}d" . "${tDir}" -x rm 
                    done <<FOUND_DIRS
${foundDirs}
FOUND_DIRS
                } || {
                    while IFS= read -r tDir ;
                    do
                        [ -z "${tDir}" ] && continue
                        set -f
                        run_priv find -L "${tDir}" ! \( ${findPru} \) \
                            -type f -mtime "+${time}" -exec rm {} \;
                        set +f
                    done <<FOUND_DIRS
${foundDirs}
FOUND_DIRS
                }
        done < "$cleaningListFile"
    }

trueOrphans="$(pacman -Qtdq || true)"
[ -n "${trueOrphans}" ] && {
    printf '%s\n' "${trueOrphans}" > ~/.config/pacman/syscpkglist.txt ;
    printf '%s\n' "${trueOrphans}" | run_priv xargs -r pacman --noconfirm -Rns ;
}
run_priv pacman --noconfirm -Sc
run_priv paccache -r

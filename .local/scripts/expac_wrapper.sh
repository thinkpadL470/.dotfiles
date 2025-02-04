#!/usr/bin/env dash
[ "${#}" -gt 2 ] && {
    printf '%s\n%s\n' \
        'more than two argument specified only specify two' \
        "use $(basename ${0}) -h to print usage" ;
    exit 1 ;
}
[ "${#}" -lt 1 ] && { 
    printf '%s\n%s\n' \
        'one argument has to be specified' \
        "use $(basename ${0}) -h to print usage" ;
    exit 1 ;
}
[ "${#}" -eq 1 -o "${#}" -eq 2 ] &&
    case "${1}" in
        -s)
            expac \
                --config "${HOME}/.config/pacman/pacman.conf" \
                -S -H M '%k\t%n'
            printf '\n%s\n' 'size of packages'
            ;;
        -u)
            expac \
                --config "${HOME}/.config/pacman/pacman.conf" \
                -S -H M "%k\t%n" $(pacman -Qqu) |
                sort -sh
            printf '\n%s\n' \
                'packages marked for update, with dl size'
            ;;
        -o)
            expac \
                --config "${HOME}/.config/pacman/pacman.conf" \
                -S '%o' 2>&1 |
                tr -s ' ' | tr -s ' ' '\n'
            printf '\n%s\n' 'optional dependencies'
            ;;
        -r)
            expac \
                --config "${HOME}/.config/pacman/pacman.conf" \
                --timefmt='%Y-%m-%d %T' '%l\t%n' |
                sort |
                tail -n 30
            printf -- '\n30 last installed\n'
            ;;
        -d)
            shift
            expac --config "${HOME}/.config/pacman/pacman.conf" \
                -S '%D' "${@}" |
                sed 's/\ \ /:/g' |
                tr ':' '\n'
            printf '\n%s\n' \
                'dependencies of package'
            ;;
        -h)
            printf '%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n' \
                "Usage: $(basename $0) [-h] [-s] [-u] [-o] [-r] [-d]" \
                '-h    Display this help' \
                '-s    Size of packages' \
                '-u    Packages marked for update, with dl size' \
                '-o    optional dependencies' \
                '-r    30 last installed' \
                '-d    <package> dependencies of package'
            ;;
    esac ; exit 0

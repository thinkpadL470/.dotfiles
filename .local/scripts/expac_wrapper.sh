#!/bin/dash
[ "${#}" -gt 1 ] && {
    printf '%s\n%s\n' \
        'more than one argument specified only specify one' \
        "use $(basename ${0}) -h to print usage" ;
}
[ "${#}" -lt 1 ] && { 
    printf '%s\n%s\n' \
        'one argument has to be specified' \
        "use $(basename ${0}) -h to print usage" ;
}
[ "${#}" -eq 1 ] &&
    case "${option}" in
        -s)
            {
                expac \
                    --config "${PACMCONF}" \
                    -S -H M '%k\t%n' ;
                printf '\n%s\n' 'size of packages' ;
            }
            ;;
        -u)
            {
                expac \
                    --config "${PACMCONF}" \
                    -S -H M "%k\t%n" $(pacman -Qqu) |
                    sort -sh ;
                printf '\n%s\n' \
                    'packages marked for update, with dl size' ;
            }
            ;;
        -o)
            {
                for line in $(expac \
                    --config "${PACMCONF}" \
                    -S '%o' 2>&1 |
                    sed 's/\ \ /:/g')
                do 
                    printf '%s\n\n' "${line}"
                done ;
            }
                printf '%s\n' 'optional dependencies'
            ;;
        -r)
            {
                expac \
                    --config "${PACMCONF}" \
                    --timefmt='%Y-%m-%d %T' '%l\t%n' |
                    sort |
                    tail -n 30 ;
                printf -- '\n30 last installed\n' ;
            }
            ;;
        -d)
            shift 1 ; {
                expac --config "${PACMCONF}" \
                    -S '%D' "$@" |
                    sed 's/\ \ /:/g' |
                    tr ':' '\n' ;
                printf '\n%s\n' \
                    'dependencies of package' ;
            }
            ;;
        -h)
            {
                printf '%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n' \
                    "Usage: $(basename $0) [-h] [-s] [-u] [-o] [-r] [-d]" \
                    '-h    Display this help' \
                    '-s    Size of packages' \
                    '-u    Packages marked for update, with dl size' \
                    '-o    optional dependencies' \
                    '-r    30 last installed' \
                    '-d    <package> dependencies of package' ;
            }
            ;;
    esac

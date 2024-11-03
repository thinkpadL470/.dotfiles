#!/bin/dash
case "$1" in
  -s) expac --config "${PACMCONF}" -S -H M '%k\t%n'
    printf -- '\nsize of packages\n'
  ;;
  -u) expac --config "${PACMCONF}" -S -H M "%k\t%n" $(pacman -Qqu) |
    sort -sh
      printf -- "\npackages marked for update, with dl size\n"
  ;;
  -o) expac --config "${PACMCONF}" -S '%o'
    printf -- '\noptional dependencies\n'
  ;;
  -r) expac --config "${PACMCONF}" --timefmt='%Y-%m-%d %T' '%l\t%n' |
    sort |
    tail -n 30
      printf -- '\n30 last installed\n'
  ;;
  -d) shift 1
    expac --config "${PACMCONF}" -S '%D' "$@" |
      sed 's/\ \ /:/g' |
      tr ':' '\n'
      printf -- '\ndependencies of package\n'
  ;;
  *) printf -- 'invalid first argument\nvalid arguments are\n'
     printf -- '-s\t\tsize of packages\n'
     printf -- '-u\t\tpackages marked for update, with dl size\n'
     printf -- '-o\t\toptional dependencies\n'
     printf -- '-r\t\t30 last installed\n'
     printf -- '-d <packages..> dependencies of package\n'
  ;;
esac

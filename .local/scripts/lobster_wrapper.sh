#!/bin/dash
[ "${#}" -gt 0 ] && case "${1}" in
    --tvs)
        lobster_quality_opts='-q 720'
        ;;
    --tvvs)
        lobster_quality_opts='-p Vidcloud -q 720'
        ;;
    *|-h)
        {
            printf '%s\n\t%s\n\t%s\n\t%s\n' \
                "Usage: $(basename $0) [--tv] [--tvs] [--tvv] [--tvvs] [-h] <search_term>" \
                '--tvs    search movies/shows 720p' \
                '--tvvs   search movies/shows 720p vidcloud source' \
                '-h      print this help' ;
        }
        ;;
esac ; shift ; { [ -n "${lobster_quality_opts}" ] && lobster ${lobster_quality_opts} ${1} ; }

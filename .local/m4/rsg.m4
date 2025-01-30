#!/bin/bash

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11  #)Created by argbash-init v2.10.0
# ARG_OPTIONAL_BOOLEAN([random-length], r, [randomize the string length between two numbers], off)
# ARG_OPTIONAL_SINGLE([charecters], c, [fixed length of string], 6)
# ARG_OPTIONAL_SINGLE([min], L, [lower end of the random string length, lower than max], 4)
# ARG_OPTIONAL_SINGLE([max], H, [highr end of the random string length, higher than min], 18)
# ARGBASH_SET_DELIM([ ])
# ARG_OPTION_STACKING([none])
# ARG_RESTRICT_VALUES([none])
# ARG_HELP([output a Random String with specifed length, uses charecter [A-Za-z1-9]])
# ARGBASH_GO

# [ <-- needed because of Argbash

# vvv  PLACE YOUR CODE HERE  vvv
usage_mg='see -h or --help for help'
[ "${_arg_random_length}" = "on" ] && {
    [ ! "${_arg_charecters}" = "6" ] && {
        printf '%s\n%s\n' "-r and -l was specified only use one of those args" \
        "${usage_mg}" ;
        exit 1 ;
    };
    [ -n "${_arg_min}" -a -n "${_arg_max}" ] && [ "${_arg_min}" -gt "${_arg_max}" ] && {
        printf '%s\n%s\n' "min (specified ${_arg_min}) has to be less than max (specified ${_arg_max})" \
        "${usage_mg}" ;
        exit 1 ;
    };
    _arg_charecters=$(($(od -An -N4 -tu /dev/urandom)${_arg_min+%(${_arg_max+$_arg_max- }$_arg_min+1)${_arg_max++$_arg_min}})) ;
    tr -cd "A-Za-z1-9" < /dev/urandom | head -c ${_arg_charecters} ;
    exit 0 ;
}
[ "${_arg_random_length}" = "off" ] && {
    tr -cd "A-Za-z1-9" < /dev/urandom | head -c ${_arg_charecters} ;
    exit 0 ;
}
# ^^^  TERMINATE YOUR CODE BEFORE THE BOTTOM ARGBASH MARKER  ^^^

# ] <-- needed because of Argbash

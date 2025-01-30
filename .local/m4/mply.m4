#!/bin/bash

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11  #)Created by argbash-init v2.10.0
# ARG_OPTIONAL_SINGLE([find_query], f, [specify find query for the current directory])
# ARG_OPTIONAL_SINGLE([mpv_options], o, [specify more mpv args])
# ARG_OPTIONAL_BOOLEAN([play_infinity], l, [loop the playlist], off)
# ARG_POSITIONAL_INF([files], [files for mpv to play disabled if use with the -f option], 0,)
# ARGBASH_SET_DELIM([ ])
# ARG_OPTION_STACKING([none])
# ARG_RESTRICT_VALUES([none])
# ARG_HELP([<The general help message of my script>])
# ARGBASH_GO

# [ <-- needed because of Argbash

# vvv  PLACE YOUR CODE HERE  vvv
erorr_mg='ERROR could not start mpv or find failed'
mpv_args='--terminal=no --mute=yes '"${_arg_mpv_options}"
[ "${_arg_play_infinity}" = "on" ] && mpv_args='--loop-playlist=inf --shuffle '"${mpv_args}"
[ -n "${_arg_find_query}" ] && find_result=$(find ./ -type f -iname "*${_arg_find_query}*" 2>/dev/null)
[ -z "${_arg_find_query}" ] &&
    setsid -f mpv ${mpv_args} "${_arg_files}" ||
    setsid -f mpv ${mpv_args} --playlist="${find_result}" || {
        printf '%s\n' "${erorr_mg}" ;
        exit 1 ;
    }  

# ^^^  TERMINATE YOUR CODE BEFORE THE BOTTOM ARGBASH MARKER  ^^^

# ] <-- needed because of Argbash

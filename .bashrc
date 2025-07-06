# -- RUNNING_INTERACTIVELY
    [ "$-" = "*i*" ] && return
# --

# -- SETTINGS
    set -o vi
    shopt -s autocd
    shopt -s histappend
    [ -e ~/.inputrc ] && bind -f "${HOME}"/.inputrc
# --

# -- VARIABLES
[ ! -d "data/data/com.termux" ] && export \
    PS1=$'\\[\e[38;2;212;212;67m\\]\u256D\u2574'"(\[\e[38;2;129;224;255m\]\u\[\e[38;2;142;178;33m\]@\[\e[38;2;164;143;230m\]\h\[\e[38;2;212;212;67m\]) \W \n\[\033[0m\]"$'\\[\e[38;2;212;212;67m\\]\u2570'"$\[\e[38;2;231;187;198m\] "
    PROMPT_COMMAND="history -a;${PROMPT_COMMAND}"
[ -d "data/data/com.termux" ] && export \
    PS1=$'\\[\e[38;2;212;212;67m\\]\u256D\u2574'"\[\e[38;2;129;224;255m\]\u\[\e[38;2;142;178;33m\]@\[\e[38;2;164;143;230m\]\h \[\e[38;2;212;212;67m\]\W \n\[\033[0m\]"$'\\[\e[38;2;212;212;67m\\]\u2570'"$\[\e[38;2;231;187;198m\] "
    PROMPT_COMMAND="history -a;${PROMPT_COMMAND}"
# --

# -- Desktop vars
[ -n "${XDG_CURRENT_DESKTOP}" ] && {
    export OPENER="xdg-open"
lwbinary=$(type librewolf) &&
    export  BROWSER="${lwbinary##* }"
}
# --

# -- NVIDIA 
[ -n "${__GL_SHADER_DISK_CACHE_PATH}" ] && export \
    __GL_SHADER_DISK_CACHE_PATH="${HOME}/.cache/nv"
# --

# -- SOURCE
# vivid_bin="$(vivid_type="$(type vivid)" ; printf '%s' "${vivid_type##* }")"
# [ -r ~/.dircolors -a ! -x "${vivid_bin}" ] &&
# eval $(dircolors -b ~/.dircolors) ;
# [ -x "${vivid_bin}" -a -d ~/.config/vivid/themes -a -r ~/.config/vivid/filetypes.yml ] &&
#     export LS_COLORS=$(vivid generate ~/.config/vivid/themes/mytheme1.yml)
[ -r ~/.bash_aliases ] &&
    . ~/.bash_aliases
[ -r ~/.config/fabric/fabric-bootstrap.inc ] &&
    . ~/.config/fabric/fabric-bootstrap.inc
[ -r /usr/share/bash-completion/bash_completion ] &&
    . /usr/share/bash-completion/bash_completion
# --

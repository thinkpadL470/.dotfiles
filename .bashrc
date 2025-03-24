# -- RUNNING_INTERACTIVELY
    [ "$-" = "*i*" ] && return
# --

# -- SETTINGS
    set -o vi
    shopt -s autocd
    shopt -s histappend
    [ -e ~/.inputrc ] && bind -f ~/.inputrc
# --

# -- VARIABLES
export \
    PS1="\[\e[38;5;33m\]\u\[\e[38;5;69m\]@\[\e[38;5;105m\]\h \[\e[38;5;141m\]\W \[\033[0m\]$ " \
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
    __GL_SHADER_DISK_CACHE_PATH="~/.cache/nv"
# --

# -- SOURCE
vivid_bin="$(vivid_type="$(type vivid)" ; printf '%s' "${vivid_type##* }")"
[ -r ~/.dircolors -a ! -x "${vivid_bin}" ] && \
    eval $(dircolors -b ~/.dircolors)
[ -x "${vivid_bin}" -a -d ~/.config/vivid/themes -a -r ~/.config/vivid/filetypes.yml ] && \
    export LS_COLORS=$(vivid generate ~/.config/vivid/themes/mytheme1.yml)
[ -r ~/.bash_aliases ] && \
    . ~/.bash_aliases
[ -r ~/.config/fabric/fabric-bootstrap.inc ] && \
    . ~/.config/fabric/fabric-bootstrap.inc
[ -r /usr/share/bash-completion/bash_completion ] && \
    . /usr/share/bash-completion/bash_completion
# --

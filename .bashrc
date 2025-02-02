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
    PS1='\[$(tput setaf 33)\]\u\[$(tput setaf 69)\]@\[$(tput setaf 105)\]\h \[$(tput setaf 141)\]\W \[$(tput sgr0)\]$ ' \
    PROMPT_COMMAND="history -a ; ${PROMPT_COMMAND}"
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
    [ -r ~/.dircolors -a ! -x ~/.cargo/bin/vivid ] && \
        eval $(dircolors -b ~/.dircolors)
    [ -x ~/.cargo/bin/vivid -a -d ~/.config/vivid/themes -a -r ~/.config/vivid/filetypes.yml ] && \
        export LS_COLORS=$(vivid generate ~/.config/vivid/themes/mytheme1.yml)
    [ -r ~/.bash_aliases ] && \
        . ~/.bash_aliases
    [ -r ~/.config/fabric/fabric-bootstrap.inc ] && \
        . ~/.config/fabric/fabric-bootstrap.inc
    [ -r /usr/share/bash-completion/bash_completion ] && \
        . /usr/share/bash-completion/bash_completion
# --

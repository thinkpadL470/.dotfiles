# -- GLOBAL
    [ -f ~/.bashrc ]&& \
        . ~/.bashrc
# --

# -- DESKTOP
    # -- VARIABLES
    export \
        PATH="${PATH}:${HOME}/.local/bin:${HOME}/.local/scripts:${HOME}/.cargo/bin" \
        HISTSIZE=100000 \
        HISTFILESIZE=100000 \
        HISTCONTROL=ignoredups \
        HISTFILE="${HOME}/.bash_history" \
        SHELL=/bin/bash \
        VISUAL=/usr/bin/nvim \
        EDITOR=/usr/bin/nvim \
        PAGER=/usr/bin/less
    [ -x "/usr/bin/foot" ] && \
        export TERM='foot'
    # --

    # -- Desktop vars
    [ -n "${XDG_CURRENT_DESKTOP}" ] && export \
        BROWSER="/usr/bin/librewolf" \
        OPENER="xdg-open"
    # --

    # -- LANG_PATH
    [ -d /usr/lib/jvm ] && export \
         RUBYPATH="~/.local/share/gem/ruby/3.2.0/bin" \
         INSTALL4J_JAVA_HOME="/usr/lib/jvm/java-8-openjdk/jre"
    # --

    # -- NVIDIA 
    [ -n "${__GL_SHADER_DISK_CACHE_PATH}" ] && export \
        __GL_SHADER_DISK_CACHE_PATH="~/.cache/nv"
    # --

    # -- SOURCE
    [ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ] && \
        . ~/.config/fabric/fabric-bootstrap.inc
    # --

# -- TERMUX
[ -d /data/data/com.termux ] && \
    for i in /data/data/com.termux/files/usr/etc/profile.d/*.sh; do test -r $i && source $i && unset i; done
# --

    # -- SOURCE
    [ -d /data/data/com.termux ] && [ "${SHELL}" = "/bin/bash" ] && \
        [ -f /data/data/com.termux/files/usr/etc/bash.bashrc ] && \
            . /data/data/com.termux/files/usr/etc/bash.bashrc && \
        [ -f /data/data/com.termux/files/home/.bashrc ] && \
            . /data/data/com.termux/files/home/.bashrc
    # --

    # -- EXEC
        [ -d /data/data/com.termux ] && \
            eval $(ssh-agent) && eval 'ssh-agent'
            [ -x ~/.local/scripts/update-env-conf.sh ] && \
            ~/.local/scripts/update-env-conf.sh
    # --
# --

# -- VARIABLES
export \
    PATH="${HOME}/.local/bin:${HOME}/.local/scripts:${PATH}" \
    HISTSIZE= \
    HISTFILESIZE= \
    HISTCONTROL=ignorespace:erasedups \
    HISTIGNORE=ct:ls:clear
    HISTFILE="${HOME}/.history" \

shbinary=$(type bash) &&
    export SHELL=${shbinary##* }

vibinary=$(type nvim) &&
    export VISUAL=${vibinary##* }

lessbinary=$(type less) &&
    export PAGER=${lessbinary##* }

export EDITOR=${VISUAL}
[ -x "/usr/bin/foot" ] && \
    export TERM='foot'
# --

# -- LANG_PATH
[ -d /usr/lib/jvm ] && export \
     RUBYPATH="~/.local/share/gem/ruby/3.2.0/bin" \
     INSTALL4J_JAVA_HOME="/usr/lib/jvm/java-8-openjdk/jre"
# --

# -- SOURCE
[ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ] &&
    . ~/.config/fabric/fabric-bootstrap.inc
# --

# -- TERMUX
[ -d /data/data/com.termux ] &&
    for i in /data/data/com.termux/files/usr/etc/profile.d/*.sh; do test -r $i && source $i && unset i; done
# --

    # -- SOURCE
    [ -d /data/data/com.termux ] && [ "${SHELL}" = "/bin/bash" ] && {
        [ -f /data/data/com.termux/files/usr/etc/bash.bashrc ] &&
            . /data/data/com.termux/files/usr/etc/bash.bashrc ;
        [ -f /data/data/com.termux/files/home/.bashrc ] &&
            . /data/data/com.termux/files/home/.bashrc ;
    }
    # --

    # -- EXEC
    [ -d /data/data/com.termux ] && {
        eval $(ssh-agent) && eval 'ssh-agent' ;
        [ -x ~/.local/scripts/update-env-conf.sh ] &&
            ~/.local/scripts/update-env-conf.sh
    }
    # --
# --

# -- GLOBAL
[ -f ~/.bashrc ] &&
    . ~/.bashrc
# --

# -- NIX
[ -f "${HOME}"/home/gus/.nix-profile/etc/profile.d/hm-session-vars.sh ] &&
    . "${HOME}"/home/gus/.nix-profile/etc/profile.d/hm-session-vars.sh
# --

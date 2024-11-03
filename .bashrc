# [BASHRC]
  # set -x
  # [?RUNNING_INTERACTIVELY?]
    [ "$-" = "*i*" ] && return
  # [SETTINGS]
    set -o vi
    shopt -s autocd
    shopt -s histappend
    [ -r -/.inputrc ] && bind -f ~/.inputrc
  # [VARIABLES]
    export \
      PS1='\[$(tput setaf 33)\]\u\[$(tput setaf 69)\]@\[$(tput setaf 105)\]\h \[$(tput setaf 141)\]\W \[$(tput sgr0)\]$ ' \
      PATH="${PATH}:${HOME}/.local/bin:${HOME}/.local/scripts:${HOME}/.cargo/bin" \
      HISTSIZE=100000 \
      HISTFILESIZE=100000 \
      HISTCONTROL=ignoredups \
      HISTFILE="${HOME}/.bash_history" \
      HISTTIMEFORMAT="[%F %T] "
      SHELL=/bin/bash
      VISUAL="/usr/bin/nvim" \
      EDITOR="/usr/bin/nvim" \
      PAGER="less"
    [ -n "${XDG_CURRENT_DESKTOP}" ] && export \
      BROWSER="/usr/bin/librewolf" \
      OPENER="xdg-open"
    # [LANG_PATH]
      [ -d /usr/lib/jvm ] && export \
        RUBYPATH="~/.local/share/gem/ruby/3.2.0/bin" \
        INSTALL4J_JAVA_HOME="/usr/lib/jvm/java-8-openjdk/jre"
  # [SOURCE]
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

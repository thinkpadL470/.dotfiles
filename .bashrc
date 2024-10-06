# [BASHRC]
  # set -x
  # [?RUNNING_INTERACTIVELY?]
    test "$-" == "*i*" && return
  # [SETTINGS]
    set -o vi
    shopt -s autocd
    shopt -s histappend
    shopt -s histverify
    test -r "$HOME/.inputrc" && bind -f ~/.inputrc
  # [VARIABLES]
    export \
      PS1='\[$(tput setaf 33)\]\u\[$(tput setaf 69)\]@\[$(tput setaf 105)\]\h \[$(tput setaf 141)\]\W \[$(tput sgr0)\]$ ' \
      PATH=$PATH:$HOME/.local/bin:$HOME/.local/scripts \
      HISTFILE=$HOME/.bash_history \
      HISTCONTROL="ignoreboth:erasedups" \
      HISTFILESIZE= \
      HISTSIZE= \
      VISUAL="/usr/bin/nvim" \
      EDITOR="/usr/bin/nvim" \
      PAGER="less"
    test -n "${XDG_CURRENT_DESKTOP}" && export \
      BROWSER="/usr/bin/librewolf" \
      OPENER="xdg-open"
    # [LANG_PATH]
      test -d "/usr/lib/jvm" && export \
        RUBYPATH=$HOME/.local/share/gem/ruby/3.2.0/bin \
        INSTALL4J_JAVA_HOME="/usr/lib/jvm/java-8-openjdk/jre"
  # [SOURCE]
    test -r "$HOME/.dircolors" && \
      eval $(dircolors -b ~/.dircolors)
    test -r "$HOME/.bash_aliases" && \
      . ~/.bash_aliases
    test -r "$HOME/.config/fabric/fabric-bootstrap.inc" && \
      . ~/.config/fabric/fabric-bootstrap.inc
    test -r "/usr/share/bash-completion/bash_completion" && \
      . /usr/share/bash-completion/bash_completion

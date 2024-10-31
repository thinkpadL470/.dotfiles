# [BASH_PROFILE]
  # [GLOBAL]
    # [SOURCE]
      test -f ~/.bashrc && \
        . ~/.bashrc
  # [DESKTOP]
    # [VARIABLES]
      test -x "/usr/bin/foot" && \
        export TERM='foot'
      # [NVIDIA]
        test -n "${__GL_SHADER_DISK_CACHE_PATH}" && export \
          __GL_SHADER_DISK_CACHE_PATH="~/.cache/nv"
    # [SOURCE]
      test -f "$HOME/.config/fabric/fabric-bootstrap.inc" && \
        . ~/.config/fabric/fabric-bootstrap.inc
  # [TERMUX]
    test -d /data/data/com.termux && \
      for i in /data/data/com.termux/files/usr/etc/profile.d/*.sh; do test -r $i && source $i && unset i; done
    # [SOURCE]
      test -d /data/data/com.termux && test "$BASH" && \
        test -f /data/data/com.termux/files/usr/etc/bash.bashrc && \
          . /data/data/com.termux/files/usr/etc/bash.bashrc && \
        test -f /data/data/com.termux/files/home/.bashrc && \
          . /data/data/com.termux/files/home/.bashrc
    # [EXEC]
      test -d /data/data/com.termux && \
        eval $(ssh-agent) && eval 'ssh-agent'
      test -x ~/.local/scripts/update-env-conf.sh && \
        ~/.local/scripts/update-env-conf.sh

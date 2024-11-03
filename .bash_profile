# [BASH_PROFILE]
  # [GLOBAL]
    # [SOURCE]
      [ -f ~/.bashrc ]&& \
        . ~/.bashrc
  # [DESKTOP]
    # [VARIABLES]
      [ -x "/usr/bin/foot" ] && \
        export TERM='foot'
      # [NVIDIA]
        [ -n "${__GL_SHADER_DISK_CACHE_PATH}" ] && export \
          __GL_SHADER_DISK_CACHE_PATH="~/.cache/nv"
    # [SOURCE]
      [ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ] && \
        . ~/.config/fabric/fabric-bootstrap.inc
  # [TERMUX]
    [ -d /data/data/com.termux ] && \
      for i in /data/data/com.termux/files/usr/etc/profile.d/*.sh; do test -r $i && source $i && unset i; done
    # [SOURCE]
      [ -d /data/data/com.termux ] && [ test "$BASH" ] && \
        [ -f /data/data/com.termux/files/usr/etc/bash.bashrc ] && \
          . /data/data/com.termux/files/usr/etc/bash.bashrc && \
        [ -f /data/data/com.termux/files/home/.bashrc ] && \
          . /data/data/com.termux/files/home/.bashrc
    # [EXEC]
      [ -d /data/data/com.termux ] && \
        eval $(ssh-agent) && eval 'ssh-agent'
        [ -x ~/.local/scripts/update-env-conf.sh ] && \
        ~/.local/scripts/update-env-conf.sh

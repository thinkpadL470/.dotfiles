#!/bin/sh
ani-cli -U && \
  sed -e '1s/#!\/bin\/sh/#!\/bin\/bash/' ~/dotfiles/.local/bin/ani-cli > ~/dotfiles/.local/bin/ani-cli.tmp && \
  chmod +x ~/dotfiles/.local/bin/ani-cli.tmp && \
  mv ~/dotfiles/.local/bin/ani-cli.tmp ~/dotfiles/.local/bin/ani-cli && \
  printf "subtituted interpeter from sh to bash\n"

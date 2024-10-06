#!/bin/bash
[ -f "$HOME/.config/pacman/pacman.conf.template" ] && \
  envsubst < ~/.config/pacman/pacman.conf.template > ~/.config/pacman/pacman.conf
[ -f "$HOME/.config/lf/lfrc.template" ] && \
  envsubst '$HOME' < ~/.config/lf/lfrc.template > ~/.config/lf/lfrc

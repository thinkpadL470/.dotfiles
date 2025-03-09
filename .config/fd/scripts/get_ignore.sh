#!/usr/bin/env dash
sed 's/-path\ //g ; s/\ -prune\ -o//g ; s/\ -prune//g ; s/\\\///g' ~/.dotfiles/.config/find/pruned > ~/.dotfiles/.config/fd/ignore

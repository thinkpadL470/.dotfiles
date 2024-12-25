#!/bin/dash
for folder in /.dotfiles /.dotfiles_privet
do
    cd ${HOME}${folder}
    stow -R .
    git assch
done


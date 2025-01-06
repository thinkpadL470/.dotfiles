#!/bin/dash
[ -d "${HOME}/.dotfiles" ] &&
    stow_foos="${HOME}/.dotfiles"
[ -d "${HOME}/.dotfiles_privet" ] &&
    stow_foos="${stow_foos} ${HOME}/.dotfiles_privet"
for folder in ${stow_foos}
do
    cd ${folder}
    stow -R --no-folding .
    { cat ${HOME}/.config/find/dotfiles* |
        while IFS= read -r target
        do
            rm -r ${HOME}/${target} 2>/dev/null
        done ;
    }
    git assch
done

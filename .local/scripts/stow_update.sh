#!/usr/bin/env dash
[ -d "${HOME}/.dotfiles" ] &&
    stow_foos="${HOME}/.dotfiles"
[ -d "${HOME}/.dotfiles_privet" ] &&
    stow_foos="${stow_foos} ${HOME}/.dotfiles_privet"
for folder in ${stow_foos}
do
    cd ${folder}
    stow -R --no-folding .
    [ -d "/data/data/com.termux/files/home" ] && {
        cat ${HOME}/.config/find/dotfiles* |
        while IFS= read -r target
        do
            rm -r ${HOME}/${target} 2>/dev/null
        done ;
    }
    [ "${1}" = "-c" ] && git assch
done
{
    type find && {
        find -L ~/.config/ ~/.local/ ~/.cache/ ~/.yt-dlp ! \( -path "${HOME}"/.local/state/nix -prune \) -type l -print0 -exec rm {} \; ;
    } && find ~/.config -type d -name '*' -print0 | while IFS= read -r -d '' dir ; do rmdir ${dir} ; done ;
} 2> /dev/null 1> /dev/null ; exit

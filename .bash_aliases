# -- GLOBAL_ALIASES
alias \
    ct="clear" \
    ls="ls --color=auto" \
    lm="ls -rt1" \
    cp="cp -iv" \
    mv="mv -iv" \
    mkd="mkdir" \
    ldf="df -H -t ext4" \
    sha="shasum -a 256" \
    ffmpeg="ffmpeg -hide_banner" \
    ffprobe="ffprobe -hide_banner" \
    grep="grep --color=auto" \
    stow="stow --no-folding"
# --

# -- LINUX_ALAISES
[ -x /usr/bin/doas ] && alias \
    sudo="doas "
# --

# -- DESKTOP_ALIASES
[ -n "${XDG_CURRENT_DESKTOP}" ] && alias \
    imv="imv -r" \
    tmuxk="tmux kill-session -t" \
    cbp="wl-paste" \
    cbc="wl-copy" \
# --

# -- TERMUX_ALIASES
[ -d /data/data/com.termux ] && alias \
    sshadd="ssh-add ~/.ssh/*-rsa" \
    sshconf="nvim ~/../usr/etc/ssh/sshd_config" \
    cbc="termux-clipboard-set" \
    cbp="termux-clipboard-get"
# --

# -- ARCH_ALIASES
[ -x /usr/bin/pacman ] &&
    export PACMCONF="${HOME}/.config/pacman/pacman.conf" && alias \
        mpkg="makepkg -cirs --config '~/.makepkg.conf'" \
        pacman="pacman --config "${PACMCONF}"" \
        downgrade="downgrade --pacman-conf "${PACMCONF}"" \
        paclunneeded="pacman -Qqd | pacman -Rsu --print -" \
# --

# -- FUNC
[ -d ~/.local/func ] && alias \
    fcd=". ~/.local/scripts/fzf_dir_jump.sh" \
    lf="~/.local/scripts/lf_wrapper.sh"
# --

# [ BASH_ALIASES ]
    # [ ALIASES ]
        # [ GLOBAL_ALIASES ]
            alias \
                ct="clear && source ~/.bashrc" \
                ls="ls --color=auto" \
                lh="ls --color=auto -hA" \
                lm="ls -rt1" \
                cp="cp -iv" \
                mv="mv -iv" \
                mkd="mkdir" \
                ldf="df -H -t ext4" \
                sha="shasum -a 256" \
                ffmpeg="ffmpeg -hide_banner" \
                ffprobe="ffprobe -hide_banner" \
                dir="dir --color=auto" \
                vdir="vdir --color=auto" \
                grep="grep --color=auto" \
                fgrep="fgrep --color=auto" \
                egrep="egrep --color=auto" \
                diff="diff --color=auto" \
                stow="stow --no-folding"
        # [ LINUX_ALAISES ]
            [ -x /usr/bin/doas ] && alias \
                sudo="doas "
            [ -d /home ] && alias \
                sudoedit="doas nvim -u ~/.config/nvim/sudoedit" \
        # [ DESKTOP_ALIASES ]
            [ -n "${XDG_CURRENT_DESKTOP}" ] && alias \
                imv="imv -r" \
                tmuxk="tmux kill-session -t" \
                cbp="wl-paste" \
                cbc="wl-copy" \
        # [ TERMUX_ALIASES ]
            [ -d /data/data/com.termux ] && alias \
                resshd="pkill sshd && sshd" \
                sshadd="ssh-add ~/.ssh/*-rsa" \
                sshconf="nvim ~/../usr/etc/ssh/sshd_config" \
                cbc="termux-clipboard-set" \
                cbp="termux-clipboard-get"
        # [ ARCH_ALIASES ]
            [ -x /usr/bin/pacman ] &&
                export PACMCONF="${HOME}/.config/pacman/pacman.conf" && alias \
                    mpkg="makepkg -cirs --config '~/.makepkg.conf'" \
                    pacman="pacman --config "${PACMCONF}"" \
                    downgrade="downgrade --pacman-conf "${PACMCONF}"" \
                    paclunneeded="pacman -Qqd | pacman -Rsu --print -" \
        # [ FUNC ]
            [ -d ~/.local/func ] && alias \
                fcd=". ~/.local/scripts/fzf_find_jump_dir.sh" \
                ffc="~/.local/scripts/fzf_find_and_copy_file_name.sh" \
                mp="~/.local/scripts/mpv_wrapper.sh" \
                lf="~/.local/scripts/lf_wrapper.sh"

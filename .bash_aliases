# [BASH_ALIASES]
  # [VARIABLES]
  export \
    esc="$(printf '\e')"
  # [ALIASES]
    # [GLOBAL_ALIASES]
      alias \
        ct="clear && source ~/.bashrc" \
        ls="ls --color=always" \
        lh="ls --color=always -hA" \
        lm="ls -rt1" \
        ll="~/.local/scripts/ll.sh" \
        rearange="~/.local/scripts/rearrange.sh" \
        tree="find . | sed -e 's/[^-][^\/]*\//  |/g' -e 's/|\([^ ]\)/|-\1/'" \
        cp="cp -iv" \
        mv="mv -iv" \
        mkd="mkdir" \
        ldu='sudo du -shc $(find -H * .* -maxdepth 0 -type d 2> /dev/null) 2> /dev/null'\
        ldf="df -H -t ext4" \
        rsy="rsync -haruvz --partial-dir='.rsync-partial' --info=progress2" \
        rsyn="rsy -n" \
        sudt="date +%y-%b-%d-%H-%M-%S" \
        netspeed="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -" \
        pubip1="curl ifconfig.me" \
        pubip2="curl ifconfig.io" \
        pubipv="curl ipinfo.io." \
        sha="shasum -a 256" \
        lufs="ebur128 --lufs" \
        gclo="git clone" \
        fdu="fdroidcl update ; fdroidcl install -u ; fdroidcl clean" \
        ffmpeg="ffmpeg -hide_banner" \
        ffprobe="ffprobe -hide_banner" \
        poicolors='for x in {0..8}; do for i in {30..37}; do echo -ne "\e[$x;$i""m$x;$i "; done; echo; done ; tput sgr0' \
        dir="dir --color=auto" \
        vdir="vdir --color=auto" \
        grep="grep --color=auto" \
        fgrep="fgrep --color=auto" \
        egrep="egrep --color=auto" \
        diff="diff --color=auto" \
        stow="stow --no-folding"
      [ -r ~/.local/scripts/rip.sh ] && alias del="rip.sh" || alias del="rip --graveyard ~/.local/share/graveyard"
    # [LINUX_ALAISES]
      [ -x /bin/doas ] && alias \
        sudo="doas "
      [ -d /home ] && alias \
        sudoedit="doas nvim -u ~/.config/nvim/sudoedit" \
        monerodrc="monerod --prune-blockchain --sync-pruned-blocks --detach" \
        wgetua="wget -U 'Mozilla/5.0 (Windows NT 10.0; rv:127.0) Gecko/20100101 Firefox/127.0'" \
        wget1="wgetua -nv -N --progress=bar --show-progress" \
        wgetO="wgetua -nv --progress=bar --show-progress" \
        wgetw="wgetua -c -N --progress=bar --wait=5s --random-wait --show-progress"
    # [DESKTOP_ALIASES]
      [ -n "${XDG_CURRENT_DESKTOP}" ] && alias \
        imv="imv -r" \
        tmuxk="tmux kill-session -t" \
        cbp="wl-paste" \
        cbc="wl-copy" \
        mpq="setsid -f mpv --terminal=no --mute=yes" \
        mpl="setsid -f mpv --loop-playlist=inf --shuffle --terminal=no --mute=yes" \
        ani="ani-cli -q 720p" \
        anid="ani --dub" \
        tv="lobster --quiet" \
        tvsd="tv -q 720" \
        tvv="lobster -p Vidcloud --quiet" \
        tvvsd="tvv -q 720" \
        pdf="zathura" \
        ytrss="newsboat -c '~/.cache/newsboat/yt-cache.db' -u '~/.config/newsboat/urls.d/yt.urls'" \
        gitrss="newsboat -c '~/.cache/newsboat/git-cache.db' -u '~/.config/newsboat/urls.d/github.urls'" \
        fdu="fdroidcl update ; fdroidcl install -u ; fdroidcl clean"
    # [TERMUX_ALIASES]
      [ -d /data/data/com.termux ] && alias \
        resshd="pkill sshd && sshd" \
        sshadd="ssh-add ~/.ssh/*-rsa" \
        sshconf="nvim ~/../usr/etc/ssh/sshd_config" \
        cbc="termux-clipboard-set" \
        cbp="termux-clipboard-get"
    # [ARCH_ALIASES]
      [ -x /usr/bin/pacman ] && export PACMCONF="${HOME}/.config/pacman/pacman.conf" && alias \
        mpkg="makepkg -cirs --config '~/.makepkg.conf'" \
        pacman="pacman --config "${PACMCONF}"" \
        downgrade="downgrade --pacman-conf "${PACMCONF}"" \
        paclunneeded="pacman -Qqd | pacman -Rsu --print -" \
        expac="expac --config "${PACMCONF}"" \
        pacls="expac -S -H M '%k\t%n' ; printf '\nsize of packages'" \
        paclu='expac -S -H M "%k\t%n" $(pacman -Qqu) | sort -sh ; printf "\npackages marked for update, with dl size\n"' \
        paclo="expac -S '%o' ; printf '\noptional dependencies\n'" \
        paclr="expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n 30 ; printf '\n30 last installed\n'" \
        pacld="expac -S '%D' package ; echo -e '\ndependencies of package'"
    # [FUNCTIONS]
      fcd () {
        [ -d /home ] && local basedir="/" && alias find="sudo find"
        [ -d /data/data/com.termux ] && local basedir="/data/data/com.termux/files/"
        cd $(find -L ${basedir} -type d \( $(cat ~/.config/find/pruned | tr '\n' ' ') \) -prune -o -type d -print 2> /dev/null | fzf --reverse --header='Change Dir')
      } ;
      ffc () {
        [ -d /home ] && local basedir="/" && alias find="sudo find"
        [ -d /data/data/com.termux ] && local basedir="/data/data/com.termux/files/"
        cbc $(find -L ${basedir} -type d \( $(cat ~/.config/find/pruned | tr '\n' ' ') \) -prune -o -type f -print 2> /dev/null | fzf --reverse --header='Copy File Path')
      } ;
      dltik () {
        [ -d /data/data/com.termux/files/ ] && local tikfailarc='~/storage/shared/Movies/tiktok/.failed-tik-dl-archive'
        yt-dlp -o "V-%(uploader)s__%(id)s__%(duration_string)s.%(ext)s" $(cbp) ||
          cbp > ${tikfailarc}
      } ;
      [ -x /bin/lemurs ] && [ -x /bin/hyprctl ] && \
      mpfd () {
        find ./ -type f -iname "*${1}*" 2>/dev/null | mpq --playlist=- &
      }

# [BASH_ALIASES]
  # [VARIABLES]
  export \
    esc="$(printf '\e')"
    # [COLORS]
    TLS_BD="${LS_COLORS%:ca=*}" TLS_CD="${LS_COLORS%:di=*}" TLS_DI="${LS_COLORS%:do=*}" TLS_DO="${LS_COLORS%:ex=*}" TLS_EX="${LS_COLORS%:pi=*}" TLS_PI="${LS_COLORS%:fi=*}" TLS_FI="${LS_COLORS%:ln=*}" TLS_LN="${LS_COLORS%:mi=*}" TLS_MH="${LS_COLORS%:or=*}" TLS_OR="${LS_COLORS%:ow=*}"
    TLS_OW="${LS_COLORS%:rs=*}" TLS_SG="${LS_COLORS%:su=*}" TLS_SU="${LS_COLORS%:so=*}" TLS_SO="${LS_COLORS%:st=*}" TLS_ST="${LS_COLORS%:tw=*}" TLS_TW="${LS_COLORS%%:\*\.*}" TLS_ARC="${LS_COLORS%%:\*.ace=*}" TLS_GF="${LS_COLORS%%:\*.rdf=*}" TLS_IM="${LS_COLORS%%:\*.avi=*}"
    TLS_AF="${LS_COLORS%%:\*.au=*}" TLS_VF="${LS_COLORS%%:\*.MOV=*}" TLS_UI="${LS_COLORS%%:\*.bak=*}"
    export \
      LS_BD="${TLS_BD##*bd=}" LS_CD="${TLS_CD##*cd=}" LS_DI="${TLS_DI##*di=}" LS_DO="${TLS_DO##*do=}" LS_EX="${TLS_EX##*ex=}" LS_PI="${TLS_PI##*pi=}" LS_FI="${TLS_FI##*fi=}" LS_LN="${TLS_LN##*ln=}" LS_MH="${TLS_MH##*mh=}" LS_OR="${TLS_OR##*or=}" \
      LS_OW="${TLS_OW##*ow=}" LS_SG="${TLS_SG##*sg=}" LS_SU="${TLS_SU##*su=}" LS_SO="${TLS_SO##*so=}" LS_ST="${TLS_ST##*st=}" LS_TW="${TLS_TW##*tw=}" LS_ARC="${TLS_ARC##*7z=}" LS_GF="${TLS_GF##*tex=}" LS_IM="${TLS_IM##*asf=}" \
      LS_AF="${TLS_AF##*aac=}" LS_VF="${TLS_VF##*mov=}" LS_UI="${TLS_UI##*aux=}"
    export \
      NC="${esc}"'[0m' BD_C="${esc}"'['"${LS_BD}"'m' CD_C="${esc}"'['"${LS_CD}"'m' DI_C="${esc}"'['"${LS_DI}"'m' DO_C="${esc}"'['"${LS_DO}"'m' EX_C="${esc}"'['"${LS_EX}"'m' PI_C="${esc}"'['"${LS_PI}"'m' FI_C="${esc}"'['"${LS_FI}"'m' LN_C="${esc}"'['"${LS_LN}"'m' MH_C="${esc}"'['"${LS_MH}"'m' \
      OR_C="${esc}"'['"${LS_OR}"'m' OW_C="${esc}"'['"${LS_OW}"'m' SG_C="${esc}"'['"${LS_SG}"'m' SU_C="${esc}"'['"${LS_SU}"'m' SO_C="${esc}"'['"${LS_SO}"'m' ST_C="${esc}"'['"${LS_ST}"'m' TW_C="${esc}"'['"${LS_TW}"'m' ARC_C="${esc}"'['"${LS_ARC}"'m' GF_C="${esc}"'['"${LS_GF}"'m' \
      IM_C="${esc}"'['"${LS_IM}"'m' AF_C="${esc}"'['"${LS_AF}"'m' VF_C="${esc}"'['"${LS_VF}"'m' UI_C="${esc}"'['"${LS_UI}"'m'
  # [ALIASES]
    # [GLOBAL_ALIASES]
      alias \
        ct="clear && source ~/.bashrc" \
        ls="ls --color=always -hA" \
        lm="ls -rt1" \
        ll="~/.local/scripts/ll.sh" \
        rearange="~/.local/scripts/rearrange.sh" \
        tree="find . | sed -e 's/[^-][^\/]*\//  |/g' -e 's/|\([^ ]\)/|-\1/'" \
        cp="cp -iv" \
        mv="mv -iv" \
        mkd="mkdir" \
        ldu='sudo du -shc $(find -H * .* -maxdepth 0 -type d)'\
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
        poicolors='for x in {0..8}; do for i in {30..37}; do echo -ne "\e[$x;$i""m$x;$i "; done; echo; done ; tput sgr0' \
        dir="dir --color=auto" \
        vdir="vdir --color=auto" \
        grep="grep --color=auto" \
        fgrep="fgrep --color=auto" \
        egrep="egrep --color=auto" \
        diff="diff --color=auto" \
        stow="stow --no-folding"
    # [LINUX_ALAISES]
      test -x "/bin/doas" && alias \
        sudo="doas "
      test -d "/home" && alias \
        sudoedit="doas nvim -u ~/.config/nvim/sudoedit" \
        monerodrc="monerod --prune-blockchain --sync-pruned-blocks --detach" \
        del="trash-put -vf" \
        wgetua="wget -U 'Mozilla/5.0 (Windows NT 10.0; rv:127.0) Gecko/20100101 Firefox/127.0'" \
        wget1="wgetua -nv -N --progress=bar --show-progress" \
        wgetO="wgetua -nv --progress=bar --show-progress" \
        wgetw="wgetua -c -N --progress=bar --wait=5s --random-wait --show-progress"
    # [DESKTOP_ALIASES]
      test -n "${XDG_CURRENT_DESKTOP}" && alias \
        rip="rip --graveyard /tmp/graveyard-${USER}" \
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
      test -d "/data/data/com.termux" && alias \
        resshd="pkill sshd && sshd" \
        sshadd="ssh-add ~/.ssh/*-rsa" \
        sshconf="nvim ~/../usr/etc/ssh/sshd_config" \
        cbc="termux-clipboard-set" \
        cbp="termux-clipboard-get"
    # [ARCH_ALIASES]
      test -x "/usr/bin/pacman" && export PACMCONF="~/.config/pacman/pacman.conf" && alias \
        mpkg="makepkg -cirs --config '~/.makepkg.conf'" \
        pacman="pacman --config "${PCCONF}"" \
        downgrade="downgrade --pacman-conf "${PCCONF}"" \
        paclunneeded="pacman -Qqd | pacman -Rsu --print -" \
        expac="expac --config "${PCCONF}"" \
        pacls="expac -S -H M '%k\t%n' ; echo '\nsize of packages'" \
        paclu='expac -S -H M "%k\t%n" $(pacman -Qqu) | sort -sh ; echo -e "\npackages marked for update, with dl size"' \
        paclo="expac -S '%o' ; echo -e '\noptional dependencies'" \
        paclr="expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n 30 ; echo -e '\n30 last installed'" \
        pacld="expac -S '%D' package ; echo -e '\ndependencies of package'"
    # [FUNCTIONS]
      fcd () {
        test -d "/home" && local badir="/" && alias find="sudo find"
        test -d "/data/data/com.termux" && local badir="/data/data/com.termux/files/"
        cd $(find -L ${badir} -type d \( $(cat ~/.config/find/pruned | tr '\n' ' ') \) -prune -o -type d -print 2> /dev/null | fzf --reverse --header='Change Dir')
      } ;
      ffc () {
        test -d "/home" && local badir="/" && alias find="sudo find"
        test -d "/data/data/com.termux" && local badir="/data/data/com.termux/files/"
        cbc $(find -L ${badir} -type d \( $(cat ~/.config/find/pruned | tr '\n' ' ') \) -prune -o -type f -print 2> /dev/null | fzf --reverse --header='Copy File Path')
      } ;
      dltik () {
        test -d "/data/data/com.termux/files/" && local tikfailarc='~/storage/shared/Movies/tiktok/.failed-tik-dl-archive'
        yt-dlp -o "V-%(uploader)s__%(id)s__%(duration_string)s.%(ext)s" $(cbp) ||
          cbp > ${tikfailarc}
      } ;
      test -x "/bin/lemurs" && test -x "/bin/hyprctl" && \
      mpfd () {
        find ./ -type f -iname "*${1}*" | mpq --playlist=- &
      }

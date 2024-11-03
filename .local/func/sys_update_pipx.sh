[ -x /bin/pipx ] &&
  [ ! -d ~/.config/pipx ] && mkdir ~/.config/pipx
  [ -x /usr/bin/pipx -a -d ~/.config/pipx ] &&
    pipx upgrade-all --skip fabric &&
      pipx list |
      grep package |
      sed 's/\ \ \ //g' |
      cut -d ' ' -f '2' > ~/.config/pipx/pipxpkgslist.txt ;

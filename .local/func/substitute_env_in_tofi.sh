[ -e ~/.config/tofi/config.template ] &&
  [ -e /usr/share/fonts/TTF/FiraCodeNerdFontMono-Regular.ttf ] &&
    fontc="/usr/share/fonts/TTF/FiraCodeNerdFontMono-Regular.ttf" ||
    fontc="sans"
  cp -L ~/.config/tofi/config.template ~/.config/tofi/config &&
    sed -i 's|\${HOME}|'"${HOME}"'|g ; s|\${fontc}|'"${fontc}"'|g' ~/.config/tofi/config

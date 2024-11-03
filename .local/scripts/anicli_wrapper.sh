#!/bin/dash
case "${1}" in
  -U) . ~/.local/func/anicli_wrapper-update.sh
  ;;
  -d) ani-cli -q 720p --dub
  ;;
  -h) printf -- 'Help\nvalid args are\n-h\tdisplay this help\n'
      printf -- '-d\twatch dubbed anime\n'
      printf -- '-U\tUpdate script subtituting interpeter to bash\n'
      printf -- 'no args\twatch subbed anime\n'
  ;;
  *) ani-cli -q 720p
  ;;
esac

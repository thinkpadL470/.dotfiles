#!/bin/dash
nocolor="${esc}"'[0m'

tls_di=${LS_COLORS%:do=*}
ls_di=${tls_di##*di=}
di_c="${esc}"'['"${ls_di}"'m'

tls_ex=${LS_COLORS%:fi=*}
ls_ex=${tls_ex##*ex=}
ex_c="${esc}"'['"${ls_ex}"'m'

tls_ln=${LS_COLORS%:mh=*}
ls_ln=${tls_ln##*ln=}
ln_c="${esc}"'['"${ls_ln}"'m'

tls_mh=${LS_COLORS%:mi=*}
ls_mh=${tls_mh##*mh=}
mh_c="${esc}"'['"${ls_mh}"'m'

tls_st=${LS_COLORS%:su=*}
ls_st=${tls_st##*st=}
st_c="${esc}"'['"${ls_st}"'m'

tls_md=${LS_COLORS%:\*\.mk=*}
ls_md=${tls_md##*\*\.md=}
md_c="${esc}"'['"${ls_md}"'m'

tls_arc=${LS_COLORS%:\*\.ha=*}
ls_arc=${tls_arc##*\*\.gz=}
arc_c="${esc}"'['"${ls_arc}"'m'

ls --color=always --time-style="+%y-%b-%d-%H-%M" -hAog ${@} |
sed -e 's/^l/'"${ln_c}"'l'"${nocolor}"'/
s/^d/'"${di_c}"'d'"${nocolor}"'/
s/^-/'"${mh_c}"'-'"${nocolor}"'/
s/r--/'"${mh_c}"'4'"${nocolor}"'/g
s/-w-/'"${mh_c}"'2'"${nocolor}"'/g
s/rw-/'"${mh_c}"'6'"${nocolor}"'/g
s/---/'"${mh_c}"'0'"${nocolor}"'/g
s/--x/'"${ex_c}"'1'"${nocolor}"'/g
s/r-x/'"${ex_c}"'5'"${nocolor}"'/g
s/-wx/'"${ex_c}"'3'"${nocolor}"'/g
s/rwx/'"${ex_c}"'7'"${nocolor}"'/g
s/rwt/'"${st_c}"'7'"${nocolor}"'/g
s/rwT/'"${st_c}"'6'"${nocolor}"'/g' |
tr -s " " "\t" | cut --complement -f '2' |
sed -e 's/\t/\ /4g ; s/\t/&'"${arc_c}"'/ ; s/\t/'"${nocolor}"'&/2' |
~/.local/scripts/rearrange.sh 1 3 4 2 |
sed -e '1d ; s/\ ..-/'"${md_c}"'&/ ; s/-..\ /&'"${nocolor}"'/ ; /\(^'"${esc}"'\['"${ls_di}"'md\|^'"${esc}"'\['"${ls_ln}"'ml\)/s/'"${esc}"'\['"${ls_arc}"'.*$//g' ;

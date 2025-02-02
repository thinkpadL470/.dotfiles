#!/usr/bin/env dash
. ~/.local/func/define_script_directories_in_variables.sh
tempfiles="$(${fu_d}/mk_tmp_f_n.sh lua_temp.pdf)"
man_link="https://lua.org/manual/5.4/manual.html"
{
    pandoc \
        --pdf-engine=xelatex \
        -o "${tempfiles% *}" "${man_link}" ;
    zathura "${tempfiles% *}" ;
    rm ${tempfiles% *} ;
}

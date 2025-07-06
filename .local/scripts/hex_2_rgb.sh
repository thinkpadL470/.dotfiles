#!/usr/bin/env dash
hexinput=`echo $1 | tr '[:lower:]' '[:upper:]'`  # uppercase-ing 
a=`echo $hexinput | cut -c-2`
b=`echo $hexinput | cut -c3-4`
c=`echo $hexinput | cut -c5-6`

r=`echo "ibase=16; $a" | bc`
g=`echo "ibase=16; $b" | bc`
b=`echo "ibase=16; $c" | bc`

printf '%s %s %s\t' $r $g $b

printf '38;2;'"${r}"';'"${g}"';'"${b}"'m\t'
printf '%s\033[38;2;'"${r}"';'"${g}"';'"${b}"'m\033[0m\n'

exit 0

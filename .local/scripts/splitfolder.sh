#!/bin/dash
working_dir="${PWD}"
number_of_dirs="${1}"
sub_dir_suffix="${2}"
n=0
for i in *
do
  test $((n+=1)) -gt ${number_of_dirs} && n=1
  sub_dir="${working_dir}/${sub_dir_suffix}_${n}"
  test -d "${sub_dir}" || mkdir "${sub_dir}" 
  mv "${i}" "${sub_dir}" 
done

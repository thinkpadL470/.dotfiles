#!/bin/dash
working_dir="${PWD}"
number_of_dirs="${1}"
sub_dir_prefix="${2}"
sub_dir_number_suffix=0
for file in *
do
  test $((sub_dir_number_suffix+=1)) -gt ${number_of_dirs} &&
    sub_dir_number_suffix=1
  sub_dir="${working_dir}/${sub_dir_prefix}_${sub_dir_number_suffix}"
  test -d "${sub_dir}" || mkdir "${sub_dir}" 
  mv "${file}" "${sub_dir}" 
done

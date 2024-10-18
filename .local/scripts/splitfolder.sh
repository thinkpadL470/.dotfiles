#!/bin/dash
parrent="${PWD}"
n=0
for i in *
do
  test $((n+=1)) -gt ${1} && n=1
  to_dir=$PARRENT/"${2}"_$n
  test -d "$to_dir" || mkdir "$to_dir" 
  mv "$i" "$to_dir" 
done

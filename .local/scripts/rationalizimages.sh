#!/bin/dash
for file in *
do
  imgformat=$(ffprobe ${file} 2>&1 | grep -m 1 -o -e '\(mjpeg\|png\)' | head -n 1)
  [ "${imgformat}" = "png" ] && ext='png' && [ ! "${file##*.}" = "png" ] &&
    mv ${file} ${file%.*}.${ext}
  [ "${imgformat}" = "mjpeg" ] && imgformat='jpg' ext='jpg' && [ ! "${file##*.}" = "jpg" ] &&
    mv ${file} ${file%.*}.${ext}
  [ ! "${file##*.}" = "${imgformat}" ] && 
    printf "format is ${imgformat} and is incorrect for original file ${file%.*}.${ext}\n"
  [ "${file##*.}" = "${imgformat}" ] &&
    printf "format is ${imgformat} and is correct for original file ${file%.*}.${ext}\n"
done ;

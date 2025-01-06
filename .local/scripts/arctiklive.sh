#!/bin/dash
main_folder="${HOME}/.local/share/pyvirt_env/tiklr"
trap "kill -- -$$" INT EXIT
for usr in $(cat ${HOME}/.yt-dlp/tik_live_urls)
do
    while true
    do
            . ${main_folder}/tiklr_env/bin/activate &&
            cd ${main_folder} &&
            python3 ${main_folder}/src/main.py \
            -mode automatic \
            -user "${usr}" \
            -ffmpeg \
            --auto-convert \
            -output "/mnt/sm3-1-1/Videos/arctiklive/"
    done &
done ;
wait

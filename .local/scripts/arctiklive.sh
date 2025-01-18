#!/usr/bin/dash
main_folder="${HOME}/.local/share/pyvirt_env/tiklr"
trap "kill -- -$$" INT EXIT
for usr in $(cat ${HOME}/.yt-dlp/tik_live_urls)
do
    while true
    do
            . ${main_folder}/tiklr_env/bin/activate &&
            cd ${main_folder}/src &&
            python3 main.py \
            -mode automatic \
            -user "${usr}" \
            -output "/mnt/sm3-1-1/Videos/arctiklive/"
    done &
done ;
wait

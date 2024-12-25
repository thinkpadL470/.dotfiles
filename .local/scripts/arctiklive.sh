#!/bin/dash
activate_sh_env="${HOME}/.local/share/pycvirtenv/tiklrenv/bin/activate"
main_sh_dir="${HOME}/.local/pythonscripts/tiklr"
trap "kill -- -$$" INT EXIT
for usr in $(cat ${HOME}/.yt-dlp/tik_live_urls)
do
    while true
    do
        {
            . ${activate_sh_env} &&
            cd ${main_sh_dir} &&
            python3 tiklr.py \
            -mode automatic \
            -user "${usr}" \
            -ffmpeg \
            --auto-convert \
            -output "/mnt/sm3-1-1/Videos/arctiklive/" ;
        }
    done &
done ;
wait

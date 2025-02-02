#!/usr/bin/env dash
printf '%s' "$$" > ${UPID_DIR}/arctiklive.pid
trap "dd if=/dev/null of=${UPID_DIR}/arctiklive.pid ; exit" INT TERM KILL
trap "kill 0" EXIT
main_folder="${HOME}/.local/share/pyvirt_env/tiklr"
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

#!/usr/bin/env dash
printf '%s' "$$" > ${UPID_DIR}/arctiklive.pid

# -- pid files
pids="${UPID_DIR}/arctiklive.pid"
# --

# -- define cleanup
cleanup () {
    {
        rm ${pids}
    } 2>/dev/null
}
# --

# -- setup traps
trap "exit" INT TERM HUP QUIT
trap "cleanup ; kill -- -$$" EXIT
# --

# -- run tikliverec py script for every user and wait
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
# --

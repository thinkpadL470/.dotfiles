kill_paper_services () {
    [ -s "${UPID_DIR}/mpvpaper_d.pid" ] &&
        kill -TERM $(cat ${UPID_DIR}/mpvpaper_d.pid) ;
    [ -s "${UPID_DIR}/hyprpaper_d.pid" ] &&
        kill -TERM $(cat ${UPID_DIR}/hyprpaper_d.pid) ;
    return 0 ;
}

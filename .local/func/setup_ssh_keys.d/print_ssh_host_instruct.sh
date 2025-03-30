print_ssh_host_instruct () {
    local ajusted_ssh_opts="$(printf '%s\n' "${ssh_opts}" | sed -e 's/-o PubkeyAuthentication=no//g')" ;
    printf '%s\n' \
        "Setup finished, now try to run:" \
        "${ssh}${ajusted_ssh_opts} ${target_host_alias:-${default_filename}}" ;
    return 0 ;
}

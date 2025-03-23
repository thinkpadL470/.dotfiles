gen_host_conf_file () {
    printf '%s\n%s\n%s\n%s\n%s\n' \
        "Host ${target_host_alias:-${default_filename}}" \
        "    Hostname ${target_hostname}" \
        "    User ${target_user}" \
        "    Port ${ssh_opts##* }" \
        "    IdentityFile ${HOME}/.ssh/${default_filename}" ;
    return 0 ;
}

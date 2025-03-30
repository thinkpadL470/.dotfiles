confirm_operations () {
    printf '\n%s%s\n%s\n\n%s\n' \
        "Transferring key from ${HOME}/.ssh/${default_filename} " \
        "to ${target_user}@${target_hostname}" \
        "using options '${ssh_opts}' " \
        "Press ENTER to continue or CTRL-C to abort" ;
    read nonsense ;
    return 0 ;
}

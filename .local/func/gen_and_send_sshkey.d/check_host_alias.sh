check_host_alias () {
    printf '%s\n' \
        "${sh_name}: no host alias(minimum 4 charecter) provided, are you sure you wanna gen conf without it" \
        "about to generate ${dfp_txt_conf_f}, that contains:" \
        "Host ${target_host_alias}" \
        "    Hostname ${target_hostname}" \
        "    User ${target_user}" \
        "    Port ${ssh_opts##* }" \
        "    IdentityFile ${HOME}/.ssh/${default_filename}" \
        "optionaly provide host alias: " ;
    return 0 ;
}

ajusted_ssh_opts="$(printf '%s\n' "${ssh_opts}" | sed -e 's/-o PubkeyAuthentication=no//g')"
printf '\n%s\n%s\n%s\n' \
    "Setup finished, now try to run:" \
    "${ssh} ${ajusted_ssh_opts} -i ${HOME}/.ssh/${default_filename} ${target_user}@${target_hostname} or " \
    "${ssh} ${ajusted_ssh_opts} ${target_host_alias:-${default_filename}}"

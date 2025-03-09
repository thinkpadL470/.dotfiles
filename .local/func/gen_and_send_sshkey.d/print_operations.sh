printf '\n%s%s\n%s%s\n\n%s\n' \
    "Transferring key from ${HOME}/.ssh/${default_filename} " \
    "to ${target_user}@${target_hostname}" \
    "using options '${ssh_opts}', keysize ${default_keysize} " \
    "and keytype: ${default_crypto_keytype}" \
    "Press ENTER to continue or CTRL-C to abort" \
read nonsense

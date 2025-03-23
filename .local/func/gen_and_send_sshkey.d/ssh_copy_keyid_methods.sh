ssh_copy_keyid_methods () {
    [ "${1}" = -d ] && return 0 ;
    { 
        [ ! -x "${ssh_copy_id}" ] && { printf '\n%s%s\n' \
            "${sh_name}: Could not find 'ssh-copy-id' " \
            "executable, using manual copy instead" ;
            cat "${HOME}/.ssh/${default_filename}.pub" |
            ${ssh} ${ssh_opts} ${target_user}@${target_hostname} 'cat >> ~/.ssh/authorized_keys' ;
        };
        [ -x "${ssh_copy_id}" ] && { printf '\n%s%s\n' \
            "Copying the key to the remote machine ${target_user}@${target_hostname}, " \
            "this usually will ask for the password" ;
            ${ssh_copy_id} ${ssh_opts} -i ${HOME}/.ssh/${default_filename}.pub ${target_user}@${target_hostname} ;
        };
    } || { printf '%s\n' "${sh_name}: ssh_copy_keyid_methods: copying ssh id failed" ; exit 1 ; }
}

#!/usr/bin/env dash
. ${HOME}/.local/func/define_script_directories_in_variables.sh
# BEGIN Define base vars
default_filename=id_test
default_crypto_keytype=ed25519
target_host=host
ssh_opts="-o PubkeyAuthentication=no"
target_user=${USER}
ssh_keygen=$(which ssh-keygen)
ssh_copy_id=$(which ssh-copy-id)
ssh=$(which ssh)
# END

# BEGIN Prosses given args
[ "${#}" -lt 1 ] && {
    . ${fu_d}/generate_and_send_ssh_key_usage.sh ; exit 2 ;
}
while [ "${#}" -gt 0 ]
do
    key="${1}" ; shift
    case ${key} in
        -n*|--host) target_host="${1}" ; shift
            ;;
        -h*|--hostname) target_hostname="${1}" ; shift
            ;;
        -u*|--user) target_user="${1}" ; shift
            ;;
        -p*|--port) ssh_opts="${ssh_opts} -p ${1}" ; shift
            ;;
        -f*|--filename) default_filename="${1}" ; shift
            ;;
        -k*|--keysize) default_keysize="${1}" ; shift
            ;;
        -t*|--keytype) default_crypto_keytype="${1}" ; shift
            ;;
        *) ${fu_d}/generate_and_send_ssh_key_usage.sh ;
            printf '%s\n' "unknown parameter: ${key}" ; exit 2
            ;;
    esac
done
# END

# BEGIN if no hostname was given offer to select from current network
[ -z "${target_hostname}" ] && {
    network_ip_list=$(${fu_d}/get_ips_in_current_network.sh | nl -s' ') ;
    number_of_ips=$(printf '%s\n' "${network_ip_list}" | wc -l) ;
    {
        printf '%s\n%s\n%s' "${network_ip_list}" \
            "target host not specified" \
            "select target host: " ;
        while true
        do
            read selection
            [ "${selection}" -eq "${selection}" ] &&
                [ "${selection}" -gt 0 ] &&
                [ "${selection}" -le "${number_of_ips}" ] &&
                break
        done ;
    };
    chosen_hostname=$(printf '%s\n' "${network_ip_list}" | sed -n ''"${selection}"'p') ;
    target_hostname=${chosen_hostname##* } ;
}
# END

# BEGIN Create Host File, and regenerate ssh config
{
    [ ! -d "${HOME}/.ssh/config.d" ] && {
        mkdir -p ${HOME}/.ssh/config.d
    };
    [ ! -f "${HOME}/.ssh/config.d/${default_filename}.txt" ] && {
        printf '%s\n%s\n%s\n%s\n%s\n' \
        "Host ${target_host}" \
        "    Hostname ${target_hostname}" \
        "    User ${target_user}" \
        "    Port ${ssh_opts##* }" \
        "    IdentityFile ${HOME}/.ssh/${default_filename}" ;
    } > ${HOME}/.ssh/config.d/${default_filename}.txt ;
    cat ${HOME}/.ssh/config.d/*.txt > ${HOME}/.ssh/config
}
# END

# BEGIN Print what the script is going to do with option to cancel or proceed
printf '\n%s%s\n%s%s\n\n%s\n' \
    "Transferring key from ${HOME}/.ssh/${default_filename} " \
    "to ${target_user}@${target_hostname}" \
    "using options '${ssh_opts}', keysize ${default_keysize} " \
    "and keytype: ${default_crypto_keytype}" \
    "Press ENTER to continue or CTRL-C to abort" \
read _
# END

# BEGIN Check if the requierd binares are avalible otherwise exit
[ -z "${ssh}" ] && {
    printf '%s\n' \
    "Could not find the ssh executable" && exit 1 ;
}
[ -z "${ssh_keygen}" ] && {
    printf '%s\n' \
    "Could not find the ssh-keygen executable" && exit 1 ;
}
[ -z "${ssh_copy_id}" ] && {
    printf '%s\n' \
    "Could not find the ssh-copy-id executable" && exit 1
}
# END

# BEGIN Check if spcified key exsists otherwise generate a new key
[ -f "${HOME}/.ssh/${default_filename}" ] && printf '\n%s\n' "Using existing key" || {
    printf '\n%s\n' "Creating a new key using ${ssh_keygen}" ;
    ${ssh_keygen} -t ${default_crypto_keytype} -f "${HOME}/.ssh/${default_filename}" ;
} || { printf '%s\n' \
    "ssh-keygen failed" ;
    exit 1 ;
}
# END

# BEGIN check if public key exists otherwise exit
[ ! -f "${HOME}/.ssh/${default_filename}.pub" ] && {
    printf '\n%s\n' \
    "Did not find the expected public key at ${HOME}/.ssh/${default_filename}.pub" ;
    exit 1 ;
}
# END

# BEGIN if keys exsist adjust premission of the keys
[ -f "${HOME}/.ssh/${default_filename}.pub" ] && [ -f "${HOME}/.ssh/${default_filename}" ] && {
    printf '\n%s\n' \
    "Adjust permissions of generated key-files locally" ;
    chmod 0600 ${HOME}/.ssh/${default_filename} ${HOME}/.ssh/${default_filename}.pub ;
} || { printf '%s\n' \
    "chmod failed" ;
    exit 1 ;
}
# END

# BEGIN copy sshid to host trying two methods exiting if ssh-copy-id failed
{
    [ ! -x "${ssh_copy_id}" ] && { printf '\n%s%s\n' \
        "Could not find the 'ssh-copy-id' " \
        "executable, using manual copy instead" ;
        cat "${HOME}/.ssh/${default_filename}.pub" |
        ssh ${ssh_opts} ${target_user}@${target_hostname} 'cat >> ~/.ssh/authorized_keys' ;
    };
    [ -x "${ssh_copy_id}" ] && { printf '\n%s%s\n' \
        "Copying the key to the remote machine ${target_user}@${target_hostname}, " \
        "this usually will ask for the password" ;
        ${ssh_copy_id} ${ssh_opts} -i ${HOME}/.ssh/${default_filename}.pub ${target_user}@${target_host} ;
    };
} || {
    printf '%s\n' "copying ssh id failed" ;
    exit 1 ;
}
# END

# BEGIN adjust premissons of relevant files in target host
{ printf '\n%s%s\n' \
    "Adjusting permissions to avoid errors in ssh-daemon, " \
    "this may ask once more for the password" ;
    ${ssh} ${ssh_opts} ${target_user}@${target_host} \
    "chmod go-w ~ && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys" ;
} || {
    printf '%s\n' "ssh-chmod failed: ${last_exit_status}" ;
    exit 1 ;
}
# END

# BEGIN Print instructions to ssh to host
printf '\n%s%s%s\n' \
    "Setup finished, now try to run ${ssh} " \
    "$(printf '%s\n' "${ssh_opts}" | sed -e 's/-o PubkeyAuthentication=no//g') " \
    "-i "${HOME}/.ssh/${default_filename}" ${target_user}@${target_host}"
# END
#

# printf '%s\n%s\n%s\n%s%s\n%s\n' \
#     " " \
#     "If it still does not work, you can try the following steps:" \
#     "- Check if ~/.ssh/config has some custom configuration for this host" \
#     "- Make sure the type of key is supported, " \
#     "e.g. 'dsa' is deprecated and might be disabled" \
#     "- Try running ssh with '-v' and look for clues in the resulting output"

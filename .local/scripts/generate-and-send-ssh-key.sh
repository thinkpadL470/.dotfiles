#!/bin/dash
. ~/.local/func/define_script_directories_in_variables.sh
{
    default_keysize=4096 ; default_filename=${HOME}/.ssh/id_test ;
    default_crypto_keytype=rsa ; default_host=host ;
    ssh_opts="-o PubkeyAuthentication=no -p 55655" ;
    default_user=${USER} ; ssh_keygen=$(which ssh-keygen) ;
    ssh=$(which ssh) ; ssh_copy_id=$(which ssh-copy-id) ;
}
[ "${#}" -lt 1 ] && {
    . ${fu_d}/generate_and_send_ssh_key_usage.sh ; exit 2 ;
}
while [ "${#}" -gt 0 ]
do
    key="${1}" ; shift
    case ${key} in
        -u*|--user) default_user="${1}" ; shift
            ;;
        -f*|--file) default_filename="${1}" ; shift
            ;;
        -h*|--host) default_host="${1}" ; shift
            ;;
        -p*|--port) ssh_opts="${ssh_opts} -p ${1}" ; shift
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

printf '%s\n%s%s%s%s\n%s\n%s\n%s\n' \
    " " \
    "Transferring key from ${default_filename} " \
    "to ${default_user}@${default_host} " \
    "using options '${ssh_opts}', keysize ${default_keysize} " \
    "and keytype: ${default_crypto_keytype}" \
    " " \
    "Press ENTER to continue or CTRL-C to abort" \
    " "
read

[ -z "${ssh_keygen}" ] &&
    printf '%s\n' \
    "Could not find the ssh-keygen executable" && exit 1

[ -z "${ssh}" ] &&
    printf '%s\n' \
    "Could not find the ssh executable" && exit 1

[ -f "${default_filename}" ] && {
    printf '%s\n' "Using existing key" ||
    {
        printf '%s\n' "Creating a new key using ${ssh_keygen}" ;
        ${ssh_keygen} -t ${default_crypto_keytype} -b ${default_keysize}  -f "${default_filename}" ;
        last_exit_status=$? ;
    };
    [ "${last_exit_status}" -ne 0 ] &&
    {
        printf '%s\n' "ssh-keygen failed: ${last_exit_status}" ;
        exit 1 ;
    };
}

[ ! -f "${default_filename}.pub" ] && { 
    printf '%s\n' \
    "Did not find the expected public key at ${default_filename}.pub" ;
    exit 1 ;
}

printf '%s\n%s\n' \
    " " \
    "Having key-information"

ssh-keygen -l -f "${default_filename}"

printf '%s\n%s\n'
    " " \
    "Adjust permissions of generated key-files locally"
chmod 0600 "${default_filename}" "${default_filename}.pub"

last_exit_status=$?
[ "${last_exit_status}" -ne 0 ] && {
    printf '%s\n' "chmod failed: ${last_exit_status}" ;
    exit 1 ;
}

printf '%s\n%s%s\n' \
    " " \
    "Copying the key to the remote machine ${USER}@${default_host}, " \
    "this usually will ask for the password"

[ -z "${ssh_copy_id}" ] && {
    {
        printf '%s\n' "Could not find the 'ssh-copy-id' executable, using manual copy instead" ;
        cat "${default_filename}.pub" |
        ssh ${ssh_opts} ${USER}@${default_host} 'cat >> ~/.ssh/authorized_keys'
    }||
    {
        ${ssh_copy_id} ${ssh_opts} -i ${default_filename}.pub ${USER}@${default_host} ;
        last_exit_status=$? ;
        [ ${last_exit_status} -ne 0 ] &&
        {
            printf '%s%s\n' \
                "Executing ssh-copy-id via ${ssh_copy_id} " \
                "failed, trying to manually copy the key-file instead" ;
            cat "${default_filename}.pub" |
            ssh ${ssh_opts} ${USER}@${default_host} 'cat >> ~/.ssh/authorized_keys' ;
        };
    };
}

last_exit_status=$?
[ ${last_exit_status} -ne 0 ] && {
    printf '%s\n' "ssh-copy-id failed: ${last_exit_status}" ;
    exit 1 ;
}

printf '%s\n%s%s\n'  \
" " \
"Adjusting permissions to avoid errors in ssh-daemon, " \
"this may ask once more for the password"

${ssh} ${ssh_opts} ${USER}@${default_host} "chmod go-w ~ && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"

last_exit_status=$?
[ ${last_exit_status} -ne 0 ] && {
    printf '%s\n' "ssh-chmod failed: ${last_exit_status}" ;
    exit 1 ;
}

printf '%s\n%s%s%s\n' \
    " " \
    "Setup finished, now try to run ${ssh} " \
    "$(printf '%s\n' "${ssh_opts}" | sed -e 's/-o PubkeyAuthentication=no//g') " \
    "-i "${default_filename}" ${USER}@${default_host}"

printf '%s\n%s\n%s\n%s%s\n%s\n' \
    " " \
    "If it still does not work, you can try the following steps:" \
    "- Check if ~/.ssh/config has some custom configuration for this host" \
    "- Make sure the type of key is supported, " \
    "e.g. 'dsa' is deprecated and might be disabled" \
    "- Try running ssh with '-v' and look for clues in the resulting output"

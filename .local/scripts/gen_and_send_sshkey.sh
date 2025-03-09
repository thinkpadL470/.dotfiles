#!/usr/bin/env dash
. ${HOME}/.local/func/define_script_directories_in_variables.sh
# -- Prosses given args, Define base vars
sfu_d=${fu_d}/gen_and_send_sshkey.d
. ${sfu_d}/vars.sh
. ${sfu_d}/check_bin.sh # check that the requierd binaries exist
[ "${#}" -lt 1 ] && {
    . ${sfu_d}/usage.sh ; exit 2 ;
}
. ${sfu_d}/sgetopts.sh
# --

# -- 
. ${sfu_d}/ls_net_ips.sh # select hostname(ip) from current network
. ${sh_d}/gen_ssh_config.sh # Create Host File, and regenerate ssh config
. ${sfu_d}/print_operations.sh # inform user about operations
# --

# -- Check if spcified key exsists otherwise generate a new key
[ -f "${HOME}/.ssh/${default_filename}" ] && printf '\n%s\n' "Using existing key" || {
    printf '\n%s\n' "Creating a new key using ${ssh_keygen}" ;
    ${ssh_keygen} -t ${default_crypto_keytype} -f "${HOME}/.ssh/${default_filename}" ;
} || { printf '%s\n' \
    "ssh-keygen failed" ;
    exit 1 ;
}
# --

. ${sfu_d}/check_pub.sh # check if public key exists otherwise exit
# -- if keys exsist adjust premission of the keys
[ -f "${HOME}/.ssh/${default_filename}.pub" ] && [ -f "${HOME}/.ssh/${default_filename}" ] && {
    printf '\n%s\n' \
    "Adjust permissions of generated key-files locally" ;
    chmod 0600 ${HOME}/.ssh/${default_filename} ${HOME}/.ssh/${default_filename}.pub ;
} || { printf '%s\n' \
    "chmod failed" ;
    exit 1 ;
}
# --

# -- copy sshid to host trying two methods exiting if ssh-copy-id failed
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
        ${ssh_copy_id} ${ssh_opts} -i ${HOME}/.ssh/${default_filename}.pub ${target_user}@${target_hostname} ;
    };
} || {
    printf '%s\n' "copying ssh id failed" ;
    exit 1 ;
}
# --

# -- adjust premissons of relevant files in target host
{ printf '\n%s%s\n' \
    "Adjusting permissions to avoid errors in ssh-daemon, " \
    "this may ask once more for the password" ;
    ${ssh} ${ssh_opts} ${target_user}@${target_hostname} \
    "chmod go-w ~ && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys" ;
} || {
    printf '%s\n' "ssh-chmod failed" ;
    exit 1 ;
}
# --

# --
. ${sfu_d}/print_ssh_host_instruct.sh # Print instructions to ssh to host
. ${sfu_d}/trubleshooting.sh # trubleshooting tips
# --

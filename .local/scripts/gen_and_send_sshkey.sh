#!/usr/bin/env dash

sh_name=$(basename $0)
ssh=$(type ssh) && ssh=${ssh##* } || ssh=""
ssh_keygen=$(type ssh-keygen) && ssh_keygen=${ssh_keygen##* } || ssh_keygen=""
ssh_copy_id=$(type ssh-copy-id) && ssh_copy_id=${ssh_copy_id##* } || ssh_copy_id=""
[ -x "${ssh}" ] || { printf '%s\n' "${sh_name}: missing requierd binary ssh" ; exit 1 ; }
[ -x "${ssh_keygen}" ] || { printf '%s\n' "${sh_name}: missing requierd binary ssh_keygen" ; exit 1 ; }
[ -x "${ssh_copy_id}" ] || { printf '%s\n' "${sh_name}: missing requierd binary ssh_copy_id" ; exit 1 ; }

usage () {
    printf '%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s%s\n\t%s\n' \
        "${sh_name}: Specify some parameters, valid ones are:" \
        "-a (--host-alias) <host>,     default: arg of file" \
        "-h (--hostname)   <hostname>, default: list ips in current network" \
        "-u (--user)       <username>, default: ${USER}" \
        "-p (--port)       <port>,     default: <default ssh port>" \
        "-f (--file)       <file>" \
        "-t (--keytype)    <type>,     default: ${default_crypto_keytype}," \
        " typical values are 'rsa' or 'ed25519'" ;
    return 0 ;
}
[ "${#}" -lt 1 ] && { usage ; exit 1 ; }
print_ssh_host_instruct () {
    local ajusted_ssh_opts="$(printf '%s\n' "${ssh_opts}" | sed -e 's/-o PubkeyAuthentication=no//g')" ;
    printf '%s\n' \
        "Setup finished, now try to run:" \
        "${ssh}${ajusted_ssh_opts} ${target_host_alias:-${default_filename}}" ;
    return 0 ;
}
troblesshooting () {
    printf '%s\n%s\n%s\n%s%s\n%s\n' \
        " " \
        "If it still does not work, you can try the following steps:" \
        "- Check if ~/.ssh/config has some custom configuration for this host" \
        "- Make sure the type of key is supported, " \
        "e.g. 'dsa' is deprecated and might be disabled" \
        "- Try running ssh with '-v' and look for clues in the resulting output" ;
    return 0 ;
}
confirm_operations () {
    printf '\n%s%s\n%s\n\n%s\n' \
        "Transferring key from ${HOME}/.ssh/${default_filename} " \
        "to ${target_user}@${target_hostname}" \
        "using options '${ssh_opts}' " \
        "Press ENTER to continue or CTRL-C to abort" ;
    read nonsense ;
    return 0 ;
}
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
gen_host_conf_file () {
    printf '%s\n%s\n%s\n%s\n%s\n' \
        "Host ${target_host_alias:-${default_filename}}" \
        "    Hostname ${target_hostname}" \
        "    User ${target_user}" \
        "    Port ${ssh_opts##* }" \
        "    IdentityFile ${HOME}/.ssh/${default_filename}" ;
    return 0 ;
}

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
pseq () {
    local min_num=${1} ;
    local step_count=${2} ;
    local max_num=${3} ;
    while [ "${min_num}" -lt "$(( ${max_num} + 1 ))" ]
    do
        printf '%s\n' "${min_num}"
        local min_num=$(( ${min_num} + ${step_count} ))
    done ;
    return 0 ;
}
choose_ip () {
    local netipa=$({
        ip a |
        sed '/\(\ lo\|inet6\)/d' |
        grep inet |
        cut -d ' ' -f '6' |
        head -n1 ;
    }) ;
    local ips_to_test=$(printf "${netipa%.*}.%s\n" $(pseq 1 1 254 | tr '\n' ' ')) ;
    local avalible_ips=$({
        for ip in ${ips_to_test}
        do
            ping -c 1 -W 1 ${ip} 2>/dev/null | grep "64 bytes" &
        done |
        cut -d ' ' -f '4' | tr -d ':' ;
    }) ;
    [ -z "${target_hostname}" ] && {
        local network_ip_list=$(printf '%s\n' "${avalible_ips}" | nl -n ln -s' ' | tr -s ' ') ;
        local number_of_ips=$(printf '%s\n' "${network_ip_list}" | wc -l) ;
        printf '%s\n%s\n%s' "${network_ip_list}" \
            "target host not specified" \
            "${sh_name}: choose_ip: select target host: "
        while true
        do
            read selection
            [ "${selection}" -eq "${selection}" ] &&
                [ "${selection}" -gt 0 ] &&
                [ "${selection}" -le "${number_of_ips}" ] &&
                break || {
                    printf '%s\n%s\n' \
                        "${sh_name}: choose_ip: index ${selection} is higer than index max ${number_of_ips} " \
                        "select a valid number in the index of the ips" ;
                    printf '%s\n%s\n' "${network_ip_list}" \
                        "${sh_name}: choose_ip: select target host: " ;
                } ;
        done ;
        local chosen_hostname=$(printf '%s\n' "${network_ip_list}" | sed -n ''"${selection}"'p') ;
        target_hostname="${chosen_hostname##* }" ;
        return 0 ;
    } ;
}

set -eu
default_filename=id_test
default_crypto_keytype=ed25519
ssh_opts="-o PubkeyAuthentication=no"
target_user=${USER}
target_hostname=""
dfp_txt_conf_f="${HOME}/.ssh/config.d/${default_filename}.conf"
while [ "${#}" -gt 0 ]
do
    key="${1}" ; shift
    case ${key} in
        -a*|--host-alias) target_host_alias="${1}" ; shift
            ;;
        -h*|--hostname) target_hostname="${1}" ; shift
            ;;
        -u*|--user) target_user="${1}" ; shift
            ;;
        -p*|--port) ssh_opts="${ssh_opts} -p ${1}" ; shift
            ;;
        -f*|--filename) default_filename="${1}" ; shift
            ;;
        -t*|--keytype) default_crypto_keytype="${1}" ; shift
            ;;
        *) usage ;
            printf '%s\n' "${sh_name}: unknown parameter: ${key}"
            exit 1
            ;;
    esac
done

[ -z "${target_hostname}" ] && choose_ip

confirm_operations

[ -f "${HOME}/.ssh/${default_filename}" ] && printf '\n%s\n' "Using existing key" || {
    printf '\n%s\n' "Creating a new key using ${ssh_keygen}" ;
    ${ssh_keygen} -t ${default_crypto_keytype} -f "${HOME}/.ssh/${default_filename}" ;
} || { printf '%s\n' "${sh_name}: ssh-keygen failed" ; exit 1 ; }

[ ! -f "${HOME}/.ssh/${default_filename}.pub" ] && {
    printf '%s\n' "${sh_name}: didnt find the expected .pub key file" ; exit 1 ;
}

printf '%s\n' "key info: $(${ssh_keygen} -l -f "${default_filename}")"

{ [ -f "${HOME}/.ssh/${default_filename}" ] && printf '\n%s\n' \
    "Adjust permissions of generated key-files locally" ;
} && { chmod 0600 ${HOME}/.ssh/${default_filename} ${HOME}/.ssh/${default_filename}.pub ||
    { printf '%s\n' "${sh_name}: chmod failed" ; exit 1 ; } ;
}

printf '%s\n' "about to copy key, proccede [y,n]: " ; read ans
[ "${ans}" = "y" ] && { ssh_copy_keyid_methods && {
    printf '\n%s%s\n' \
    "Adjusting permissions to avoid errors in ssh-daemon, " \
    "this may ask once more for the password" ;
} && ${ssh} ${ssh_opts} ${target_user}@${target_hostname} \
    "chmod go-w ~ && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys" ||
    { printf '%s\n' "${sh_name}: ssh-chmod failed" ; exit 1 ; }
} || ssh_copy_keyid_methods -d

[ ! -d "${HOME}/.ssh/config.d" ] && {
    mkdir -m 700 ${HOME}/.ssh ; mkdir -m 700 ${HOME}/.ssh/config.d ;
}
[ -z "${target_host_alias}" ] && { check_host_alias ; read target_host_alias ; };
[ "${#target_host_alias}" -le 3 ] && {
    printf '%s\n' \
        "${sh_name}: alias has to be atleast 4 charecters" \
        "using ${default_filename} instead" ;
        target_host_alias=${default_filename} ;
}
conf_id_file=$(gen_host_conf_file) ;
printf '%s\n' \
    "about to generate ${dfp_txt_conf_f}, that contains:" \
    "${conf_id_file}" \
    "proccede [y,n]: " ;
read ans ;
[ "${ans}" "y" ] && { printf '%s\n' "${conf_id_file}" > ${dfp_txt_conf_f} ; }
chmod 700 ${HOME}/.ssh/config.d
chmod 600 ${HOME}/.ssh/config ${HOME}/.ssh/config.d/*.conf

print_ssh_host_instruct
troblesshooting

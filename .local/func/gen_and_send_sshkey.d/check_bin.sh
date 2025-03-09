[ -z "${ssh}" ] && {
    printf '%s\n' \
    "Could not find the ssh executable" ; exit 1 ;
}
[ -z "${ssh_keygen}" ] && {
    printf '%s\n' \
    "Could not find the ssh-keygen executable" ; exit 1 ;
}
[ -z "${ssh_copy_id}" ] && {
    printf '%s\n' \
    "Could not find the ssh-copy-id executable" ; exit 1 ;
}

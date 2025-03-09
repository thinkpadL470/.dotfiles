[ ! -f "${HOME}/.ssh/${default_filename}.pub" ] && {
    printf '\n%s\n' \
    "Did not find the expected public key at ${HOME}/.ssh/${default_filename}.pub" ;
    exit 1 ;
}

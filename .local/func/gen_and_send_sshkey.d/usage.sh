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

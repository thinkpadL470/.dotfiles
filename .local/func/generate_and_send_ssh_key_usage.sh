printf '%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s%s\n\t%s\n' \
    "Specify some parameters, valid ones are:" \
    "-u (--user)       <username>, default: ${USER}" \
    "-f (--file)       <file>,     default: ${default_filename}" \
    "-h (--host)       <host>, default: ${default_host}" \
    "-n (--hostname)   <hostname>, default: ask in current network if not specified" \
    "-p (--port)       <port>,     default: <default ssh port>" \
    "-k (--keysize)    <size>,     default: ${default_keysize}" \
    "-t (--keytype)    <type>,     default: ${default_crypto_keytype}," \
    " typical values are 'rsa' or 'ed25519'" \
    "-P (--passphrase) <key-passphrase>, default: ${default_passphrase}"

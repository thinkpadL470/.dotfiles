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
        -k*|--keysize) default_keysize="${1}" ; shift
            ;;
        -t*|--keytype) default_crypto_keytype="${1}" ; shift
            ;;
        *) ${sfu_d}/usage.sh ;
            printf '%s\n' "unknown parameter: ${key}" ; exit 2
            ;;
    esac
done

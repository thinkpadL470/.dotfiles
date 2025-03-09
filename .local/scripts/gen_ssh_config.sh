#!/usr/bin/env dash
{
    [ ! "$1" = "-u" ] && {
        dfp_txt_f="${HOME}/.ssh/config.d/${default_filename}.txt"
        [ ! -d "${HOME}/.ssh/config.d" ] && {
            mkdir -m 700 ${HOME}/.ssh ; mkdir -m 700 ${HOME}/.ssh/config.d ;
        };
        gen_conf_id_file=$({ printf '%s\n%s\n%s\n%s\n%s\n' \
            "Host ${target_host_alias:-${default_filename}}" \
            "    Hostname ${target_hostname}" \
            "    User ${target_user}" \
            "    Port ${ssh_opts##* }" \
            "    IdentityFile ${HOME}/.ssh/${default_filename}" ;
        });
        ! { printf '%s\n' "${gen_conf_id_file}" |
            cmp - ${dfp_txt_f} ;
        } && { printf '%s\n' "${gen_conf_id_file}" > ${HOME}/.ssh/config.d/${default_filename}.txt ;
        };
    };
    cat ${HOME}/.ssh/config.d/*.txt > ${HOME}/.ssh/config
    chmod 600 ${HOME}/.ssh/config
}

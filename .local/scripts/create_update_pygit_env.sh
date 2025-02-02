#!/usr/bin/env dash
[ "${1}" = "-h" ] && {
    printf '%s\n%s\n%s\n%s\n' \
        "first argument is the github repo that shall be cloned" \
        "second argument is the name of the virtaul enviorment/folder" \
        "if the "
        exit 0 ;
}
git_repo_link="${1}"
git_folder="${HOME}/.local/share/pyvirt_env/${2}"
env_folder="${git_folder}/${2}_env"
{
    [ ! -d "${git_folder%/*}" ] && mkdir -p ${git_folder%/*} ;
    [ -d "${git_folder%/*}" ] && cd ${git_folder%/*} ;
    [ ! -d "${git_folder}" ] && {
        git clone ${git_repo_link} ;
        mv ${git_repo_link##*/} ${git_folder} ;
        cd ${git_folder} ;
        printf '%s\n' "${1}" > ${git_folder}/giturl ;
    };
    [ -d "${git_folder}/.git" ] && git pull ;
    [ ! -d "${env_folder}" ] && python -m venv ${git_folder##*/}_env ;
    [ -d "${env_folder}" ] && {
        reqfile=$(find . -type f -name 'requirements.txt')
        . ${env_folder}/bin/activate && {
            pip3 install -r ${reqfile} ;
            pip3 install -U -r ${reqfile} ;
        };
    };
}

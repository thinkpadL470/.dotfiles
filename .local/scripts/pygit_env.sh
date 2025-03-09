#!/usr/bin/env dash
set -x
[ "${1}" = "-h" -o "${#}" -lt 1 ] && {
    printf '%s\n%s\n\n%s\n%s\n' \
        "first argument is the github repo that shall be cloned" \
        "second argument is the name of the virtaul enviorment and main folder(no spaces and quote it)" \
        "if this tool has alredy been used it updates the git repo thats been created, " \
        "and the python enviorment, just provide the name of the git folder as first arg"
        exit 0 ;
}
[ "${#}" -gt 1 ] && git_repo_link="${1}"
name="${2}"
reponame="$(var1=${git_repo_link##*/} ; printf '%s' ${var1%.*})"
git_folder="${HOME}"/.local/share/pyvirt_env/"${name}"
env_folder="${git_folder}"/"${name}"_env
{
    [ ! -d "${git_folder%/*}" ] && mkdir -p ${git_folder%/*} ;
    [ -d "${git_folder%/*}" ] && cd ${git_folder%/*} ;
    [ ! -d "${git_folder}" ] && {
        cd ${git_folder%/*} ;
        git clone ${git_repo_link} ;
        mv ${git_folder%/*}/${reponame} ${git_folder} ;
        cd ${git_folder} ;
        printf '%s\n' "${git_repo_link}" > ${git_folder}/giturl ;
    };
    [ -d "${git_folder}/.git" ] && git pull ;
    [ ! -d "${env_folder}" ] && { cd ${git_folder} ; python -m venv "${name}_env" ; };
    [ -d "${env_folder}" ] && {
        cd ${git_folder} ;
        reqfile=$(find . -type f -name 'requirements.txt') ;
        . ${env_folder}/bin/activate && {
            pip3 install -r ${reqfile} ;
            pip3 install -U -r ${reqfile} ;
        };
    };
}

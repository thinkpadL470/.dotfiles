#!/bin/dash
git_repo="${1}"
main_folder="${HOME}/.local/share/pyvirt_env/${2}"
env_folder="${main_folder}/${2}_env"
{
    [ ! -d "${main_folder%/*}" ] && mkdir -p ${main_folder%/*} ;
    [ -d "${main_folder%/*}" ] && cd ${main_folder%/*} ;
    [ ! -d "${main_folder}" ] && {
        git clone ${git_repo} ;
        mv ${git_repo##*/} ${main_folder} ;
        cd ${main_folder} ;
    };
    printf '%s\n' "${1}" > ${main_folder}/giturl ;
    [ -d "${main_folder}/.git" ] && git pull ;
    [ ! -d "${env_folder}" ] && python -m venv ${main_folder##*/}_env ;
    [ -d "${env_folder}" ] && {
        reqfile=$(find . -type f -name 'requirements.txt')
        . ${env_folder}/bin/activate && {
            pip3 install -r ${reqfile} ;
            pip3 install -U -r ${reqfile} ;
        };
    };
}

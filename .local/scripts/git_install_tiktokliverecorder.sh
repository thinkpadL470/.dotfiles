#!/usr/bin/env dash
git_repo="https://github.com/Michele0303/tiktok-live-recorder"
main_folder="${HOME}/.local/share/pyvirt_env/tiklr"
env_folder="${main_folder}/${main_folder##*/}_env"
{
    [ ! -d "${main_folder%/*}" ] && mkdir -p ${main_folder%/*} ;
    [ -d "${main_folder%/*}" ] && cd ${main_folder%/*} ;
    [ ! -d "${main_folder}" ] && {
        git clone ${git_repo} ;
        mv ${git_repo##*/} ${main_folder} ;
        cd ${main_folder} ;
    };
    [ -d "${main_folder}/.git" ] && git pull ;
    [ ! -d "${env_folder}" ] && python -m venv ${main_folder##*/}_env ;
    [ -d "${env_folder}" ] && {
        . ${env_folder}/bin/activate && {
            pip3 install -r $(find . -type f -name 'requirements.txt') ;
            pip3 install -U -r $(find . -type f -name 'requirements.txt') ;
        };
    };
}

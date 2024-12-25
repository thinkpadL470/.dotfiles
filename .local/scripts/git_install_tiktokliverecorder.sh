#!/bin/dash
git_repo="https://github.com/Michele0303/tiktok-live-recorder"
main_folder="${HOME}/.local/share/pyvirt_env/tiklr"
{
    [ ! -d "${main_folder%/*}" ] && mkdir -p ${main_folder%/*} ;
    [ ! -d "${main_folder}" ] && {
        cd ${main_folder%/*} ;
        git clone ${git_repo} ;
        mv ${git_repo##*/} ${main_folder} ;
    };
    [ ! -d "${main_folder}${main_folder##*/}_env" ] && {
        cd ${main_folder} ;
        python -m venv ${main_folder##*/}_env ;
    };
    [ -d "${main_folder}${main_folder##*/}_env" ] && {
        cd ${main_folder} ;
        . ./bin/activate && {
            pip3 install -r ./requirements.txt ;
            pip3 install -U -r ./requirements.txt ;
        };
    };
}

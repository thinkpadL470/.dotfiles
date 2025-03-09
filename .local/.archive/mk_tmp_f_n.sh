. ~/.local/func/define_script_directories_in_variables.sh
for prefix in ${@}
do
    printf \
        '%s\n' \
        "${PWD}/.${prefix}.$(${bi_d}/rsg -r -H 12) "
done

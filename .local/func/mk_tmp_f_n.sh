. ~/.local/func/define_script_directories_in_variables.sh
for prefix in ${@}
do
    printf \
        '%s' \
        "${PWD}/.${prefix}.$(${fu_d}/output_random_number_string.sh 6) "
done

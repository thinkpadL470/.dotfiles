[ "${image_format}" = "empty" ] || [ "${original_extention}" = "${new_extention}" ] &&
	printf "format is ${image_format}\t" &&
	printf "and is correct for original file " &&
	printf "${file%.*}.${original_extention}\n"

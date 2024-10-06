for f in *.m4a;  do
	[ -f "$f" ] || continue
  ffmpeg -i "$f" "${f%%.*}.flac"
done

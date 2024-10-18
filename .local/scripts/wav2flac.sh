for f in *.wav;  do
	[ -f "$f" ] || continue
  ffmpeg -i "$f" "${f%%.*}.flac"
done

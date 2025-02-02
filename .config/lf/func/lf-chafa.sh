#!/usr/bin/env dash
# -- generate thumbnail for video and images
case "$(file -Lb --mime-type -- "$1")" in
    image/vnd.microsoft.icon)
        ffmpeg -i ${1} -f webp - |
        chafa -f sixel -s "${2}x${3}" --animate off --polite on "-"
            exit 1
            ;;
    image/*)
        chafa -f sixel -s "${2}x${3}" --animate off --polite on "$1"
        ;;
    video/*)
        ffmpegthumbnailer -i "$1" -q 5 -s 0 -c jpg -o - |
        chafa -f sixel -s "${2}x${3}" --animate off --polite on "-"
            exit 1
            ;;
    *)
        cat "$1"
        ;;
esac
# --

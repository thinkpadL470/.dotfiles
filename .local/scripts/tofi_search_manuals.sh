#!/usr/bin/env dash
pdfselect=$(man -k . 2>&1 | cut -d ' ' -f '1-2' | tr -d ' ' | sort | uniq | tofi --matching-algorithm='normal' --prompt-text='man:' --placeholder-text='open manual...') &&
    man -Tpdf ${pdfselect} | zathura - ||
    exit 0

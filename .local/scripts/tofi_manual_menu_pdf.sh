#!/usr/bin/dash
pdfselect=$(man -k . 2>&1 | cut -d ' ' -f '1-2' | tr -d ' ' | sort | uniq | tofi --matching-algorithm='normal' --prompt-text='man:') &&
  man -Tpdf ${pdfselect} | zathura - ||
  exit 0

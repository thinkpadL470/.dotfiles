#!/bin/dash
xdg_mime_pdf_viewer_filetypes=$(for filetype in pdf octet-stream; do printf "|application/${filetype}"; done)
xdg_mime_text_file_editor_filetypes=$(for filetype in json lua; do printf "|application/${filetype}"; done)

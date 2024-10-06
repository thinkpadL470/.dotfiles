#!/bin/dash
unset fssexp rearrangeexp;
rearrangeexp="{ print "; while [ "$1" ]; do rearrangeexp="$rearrangeexp\$$1\" \" "; shift; done; rearrangeexp="$rearrangeexp }";
fssexp='{FS="\t"; OFS=" "}';
awk "BEGIN ${fssexp} ${rearrangeexp}"

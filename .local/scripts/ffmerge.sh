#!/bin/sh

# FFMERG
# Version: 1.0.0
# License: Open Source (MIT)
# Copyright (c) 2018 Niranjan Kalyanasundaram
# Dependancy: ffmpeg

# Script to merge all files (of a given extension) in a given directory (without reencoding) using FFMPEG (ex: all .mp4 files in ~/Movies )
# It is assumed that all target files have originated from the same device (encoded using the same codec, container, dimensions, etc)
# Files created from different sources cannot be merged (see ffmpeg concat command and -c flag for further info)
# ffmerge <targetdir> <extension> <outfile>

if ! ([ $1 ] && [ $2 ] && [ $3 ])     
# check for command line args
then
    echo "ffmerge uses ffmpeg to merge video or audio files in a given folder"
    echo "WARNING: It is assumed that all target files have originated from a single source (same codec, container, etc)"
    echo "usage: ffmerge targetfoler extension outfile"
    echo "example: ffmerge /usr/Videos .mp4 merged.mp4"
    exit
fi

# $1 contains target folder
# $2 contains target file extension
# $3 output file name
$initial_dir=pwd
cd "$1"
echo "Generating list of input videos..."
echo "# Videos to merge" > concat.txt
for file in *$2
do
    echo "file '$file'" >> concat.txt
done
echo "Input file genereated!"
echo "Using ffmpeg to merge files..."
ffmpeg -f concat -i concat.txt -c copy $3
rm concat.txt
cd "$initial_dir"
echo "Videos merged!"

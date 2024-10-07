#!/bin/sh

## Variable.sys
MONN="HDMI-A-1"
HYPC="${HOME}/dotfiles/.config/hypr/hyprpaper.conf"
wp="${HOME}/.bg"

## Variable.quality
api="https://wallhaven.cc/api/v1/search?"
key=c86dmCDQFYo5E5s1CQ4sTlRddvYmOKtO
q=
categories=110
purity=110
sorting=random
atleast=1920x1080
ratios=landscape

## Variable.url
API_URL="${api}apikey=${key}&q=${keywords}&categories=${categories}&purity=${purity}&ratios=${ratios}&sorting=${sorting}"
API_CURL=$(curl -sS --max-time 10 --retry 2 --retry-delay 3 --retry-max-time 20 "${API_URL}")
IMAGE_URL=$(echo "${API_CURL}" | jq -r '[.data[] | .path] | .[0]')

## Functions
reloadconf () { echo -e "preload = ${wp} \n wallpaper = ${MONN},${wp} \n splash = false > ${HYPC}" ; }
defimage() { curl -s ${IMAGE_URL} > ${wp} ; }

## Exec
[[ "$(pgrep hyprpaper)" == "" ]] && [[ "$(pgrep mpvpaper)" == "" ]] && defimage && reloadconf && hyprpaper ||
pkill 'hyprpaper|mpvpaper' && defimage && reloadconf && hyprpaper ;

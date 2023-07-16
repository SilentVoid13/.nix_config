#!/usr/bin/env bash

wallpaper_folder="$HOME/.wallpapers"
delay=3600
wallpaper=""

random_wallpaper() {
    wallpaper=$(find $wallpaper_folder -maxdepth 1 -regex ".*\.\(jpg\|png\|jpeg\)" | shuf -n1)
}

while true 
do
    random_wallpaper
    wbg $wallpaper &
    last_pid=$!
    sleep 3600
    kill $last_pid
done

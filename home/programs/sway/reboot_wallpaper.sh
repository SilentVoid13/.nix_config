#!/usr/bin/env bash

pkill -TERM -f wbg
pkill -TERM -f wallpaper_switcher
~/.config/sway/scripts/wallpaper_switcher.sh &

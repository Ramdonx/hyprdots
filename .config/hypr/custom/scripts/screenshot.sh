#!/bin/bash

DIR="$HOME/Pictures/Screenshots"
FILENAME="screenshot-$(date +'%Y%m%d-%H%M%S').png"
FULL_PATH="$DIR/$FILENAME"

mkdir -p "$DIR"

case "$1" in
    "full")
        grim "$FULL_PATH"
        wl-copy < "$FULL_PATH"
        notify-send "Screen Capture" "Screen Capture Save"
        ;;
    "area")
        grim -g "$(slurp)" "$FULL_PATH"
        wl-copy < "$FULL_PATH"
        notify-send "Screen Capture" "Screen Capture Save"
        ;;
    "window")
        grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" "$FULL_PATH"
        wl-copy < "$FULL_PATH"
        notify-send "Screen Capture" "Screen Capture Save"
        ;;
    *)
        echo "Uso: $0 {full|area|window}"
        exit 1
        ;;
esac

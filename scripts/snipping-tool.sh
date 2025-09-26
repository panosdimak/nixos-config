#!/usr/bin/env bash
set -euo pipefail

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

# temp file (only kept if you choose Save)
TMP="$(mktemp --suffix=.png)"

# take region; if you cancel selection, exit cleanly
if ! grim -g "$(slurp)" "$TMP"; then
  rm -f "$TMP"
  exit 0
fi

# copy to clipboard right away (Windows-like)
wl-copy < "$TMP"

# Ask what to do; returns the *action name* on stdout (e.g. "edit", "save", "discard")
choice="$(
  notify-send \
    -a "Screenshot" \
    -i "$TMP" \
    -u low \
    -t 6000 \
    -A "edit=Edit in Swappy" \
    -A "save=Save to file" \
    -A "discard=Discard" \
    "Screenshot taken" "Choose what to do (or ignore)" \
    --wait
)"

case "$choice" in
  edit|1)
    # open swappy; when you close it, clean up the temp
    swappy -f "$TMP"
    rm -f "$TMP"
    ;;
  save|2)
    FILE="$DIR/Screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"
    mv "$TMP" "$FILE"
    notify-send -a "Screenshot" -i "$FILE" "Saved" "$FILE"
    ;;
  discard|3|"")
    # closed/ignored → just discard file (clipboard keeps working)
    rm -f "$TMP"
    ;;
esac

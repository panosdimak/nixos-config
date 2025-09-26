#!/usr/bin/env bash 

set -euo pipefail

IMG=$(mktemp --suffix=.png)

grim -g "$(slurp)" "$IMG"

tesseract "$IMG" - -l eng+ell | wl-copy

rm -f "$IMG"

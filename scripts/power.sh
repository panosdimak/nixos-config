#!/usr/bin/env bash
set -euo pipefail

options=" Lock\n⏾ Sleep\n󰍃 Logout\n Reboot\n Shutdown\n Reboot to Firmware\nCancel"

choice=$(echo -e "$options" | fuzzel --dmenu --lines=6 --prompt="Power > ") || exit 0

# Strip leading icon (everything up to the first space) so matching works with icons
label="$choice"
if [[ "$label" == *" "* ]]; then
  label="${label#* }"
fi

case "$label" in
  Lock) hyprlock ;;
  Sleep) systemctl suspend ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
  Logout) hyprctl dispatch exit ;;
  "Reboot to Firmware") systemctl reboot --firmware-setup ;;
  Cancel|"") exit 0 ;;
esac

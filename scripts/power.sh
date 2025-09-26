#!/usr/bin/env bash
set -euo pipefail

options="Lock\nSleep\nLogout\nReboot\nShutdown\nReboot to Firmware\nCancel"

choice=$(echo -e "$options" | fuzzel --dmenu --lines=6 --prompt="Power > ") || exit 0

case "$choice" in
  Lock) hyprlock ;;
  Sleep) systemctl suspend ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
  Logout) hyprctl dispatch exit ;;
  "Reboot to Firmware") systemctl reboot --firmware-setup ;;
  Cancel|"") exit 0 ;;
esac

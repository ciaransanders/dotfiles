#!/usr/bin/env bash
# Prints the SSH icon path (for waybar's image module) while SSH mode is on.
# ssh_mode.sh sends SIGRTMIN+8 to waybar on toggle to refresh this.

[ "$("$HOME/.config/eww/scripts/ssh_mode.sh" status)" = true ] &&
  echo "$HOME/.config/waybar/images/ssh.svg"
exit 0

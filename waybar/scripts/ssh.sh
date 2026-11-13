#!/usr/bin/env bash
# Prints an icon while SSH mode is on.
# ssh_mode.sh sends SIGRTMIN+8 to waybar on toggle to refresh this.

[ "$("$HOME/.config/eww/scripts/ssh_mode.sh" status)" = true ] && echo ''
exit 0

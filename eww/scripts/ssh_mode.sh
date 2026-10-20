#!/bin/bash
# Toggle "SSH mode": sshd running + lid switch/sleep inhibited, so the machine
# stays reachable with the lid closed. Nothing persists across reboots.
# Args:
#   toggle | on | off | status

UNIT="ssh-mode-inhibit"

is_on() {
  systemctl --user is-active --quiet "$UNIT"
}

on() {
  # Prompts via hyprpolkitagent; bail if the prompt is cancelled
  systemctl start sshd || exit 1
  systemd-run --user --collect --unit="$UNIT" --description="SSH mode inhibitor" \
    systemd-inhibit --what=handle-lid-switch:sleep --who="ssh-mode" --why="WFH ssh" \
    sleep infinity
}

off() {
  systemctl --user stop "$UNIT"
  systemctl stop sshd
}

case "$1" in
  toggle) if is_on; then off; else on; fi ;;
  on)     is_on || on ;;
  off)    is_on && off ;;
  status) if is_on; then echo true; else echo false; fi; exit 0 ;;
  *)      echo "usage: $0 {toggle|on|off|status}" >&2; exit 1 ;;
esac

# Push the new state to eww immediately instead of waiting for the next poll
eww update ssh_mode="$("$0" status)"

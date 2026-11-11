#!/usr/bin/env bash
# Prints an icon when the active workspace has the SUPER+G big-gaps rule enabled.
# Hyprland's config sends SIGRTMIN+9 to waybar on toggle / workspace change to refresh this.

ws="$(hyprctl activeworkspace -j | jq -r '.name')"
hyprctl workspacerules -j |
  jq -e --arg ws "$ws" 'any(.[]; .workspaceString == $ws and .enabled and has("gapsOut"))' >/dev/null &&
  echo '󰘖'
exit 0

#!/usr/bin/env bash
# Prints an icon when the active workspace has a fullscreen window.
# Hyprland's config sends SIGRTMIN+10 to waybar on fullscreen / focus / workspace changes to refresh this.

hyprctl activeworkspace -j | jq -e '.hasfullscreen' >/dev/null && echo '󰊔'
exit 0

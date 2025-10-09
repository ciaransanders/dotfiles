#!/bin/bash

LOCK_FILE="/tmp/eww-volume-popup.lock"

show_popup() {
  # Kill any existing popup timer
  if [ -f "$LOCK_FILE" ]; then
    old_pid=$(cat "$LOCK_FILE")
    kill "$old_pid" 2>/dev/null
  fi

  # Store this process's PID
  echo $BASHPID >"$LOCK_FILE"

  # Show the popup
  if [ ! "$(eww active-windows | grep -oP "volume_popup:" | tr -d ":")" ]; then
    eww open volume_popup
  fi

  sleep 2

  # Only hide if we're still the active popup process
  if [ -f "$LOCK_FILE" ] && [ "$(cat "$LOCK_FILE")" = "$BASHPID" ]; then
    eww close volume_popup
    rm "$LOCK_FILE"
  fi
}

# Output initial volume on startup
eww update volume="$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume:/ {print $5}' | tr -d '%')"

# Listen for changes
pactl subscribe | grep --line-buffered "'change' on sink" | while read -r _; do
  # Trigger the popup in the background
  show_popup &
done

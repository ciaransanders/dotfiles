#!/bin/bash

LOCK_FILE="/tmp/eww-volume-popup.lock"
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume:/ {print $5}' | tr -d '%')

update_volume_variable() {
  # Update the volume variable for eww
  VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume:/ {print $5}' | tr -d '%')
  if [ "$VOLUME" == 1 ]; then
    VOLUME=0
  fi
  eww update volume="$VOLUME"
}

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
    eww open volume_popup --screen "$(hyprctl monitors -j | jq '.[] | select(.focused == true) | .id')"
  fi

  sleep 2

  # Only hide if we're still the active popup process
  if [ -f "$LOCK_FILE" ] && [ "$(cat "$LOCK_FILE")" = "$BASHPID" ]; then
    eww close volume_popup
    rm "$LOCK_FILE"
  fi
}

# Initialize volume variable in eww
update_volume_variable

# Listen for changes to volume in pipewire using pactl
pactl subscribe | grep --line-buffered "'change' on sink" | while read -r _; do

  # Update volume variable
  OLD_VOLUME=$VOLUME
  update_volume_variable

  # Trigger the popup in the background
  if [ ! "$VOLUME" == "$OLD_VOLUME" ]; then
    show_popup &
  fi

done

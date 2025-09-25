#!/bin/bash

# Wait for hyprpaper to load
while ! pgrep -x hyprpaper >/dev/null; do
  sleep 0.5
done

sleep 1

# Copy current wallpaper to .current_wall
WALLPAPER=$(hyprctl hyprpaper listactive | sed 's/^[^=]*= *//g' | head -n 1)
cp $WALLPAPER ~/.config/hypr/.current_wall

# Run eww daemon if not running already
EWW=$(which eww)
if [[ ! $(pidof eww) ]]; then
  ${EWW} daemon
  sleep 1
fi

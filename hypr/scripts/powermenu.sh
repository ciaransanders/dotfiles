# Script for opening the powermenu on the currently focused window,
# and opening the helper powermenu-closer on all windows

for screen in $(hyprctl monitors -j | jq '.[].id'); do
  eww open powermenu-closer --toggle --id "powermenu-closer-$screen" --screen "$screen"
done

eww open powermenu --toggle --screen "$(hyprctl activewindow -j | jq '.monitor')"

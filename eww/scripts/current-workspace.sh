socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | grep "activespecial>>"
socat UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock STDOUT | sed -u 's/activespecial>>\([^,]*\).*/\1/p' | sed -u -n '/^special/p'

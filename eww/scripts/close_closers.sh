# Close all closer helpers currently open for the window
# Args:
#   window: name of the window

eww close "$1"

for id in $(eww active-windows | grep -oP "$1-closer-\d+"); do
  eww close "$id"
done

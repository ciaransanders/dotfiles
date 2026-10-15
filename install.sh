#!/bin/sh
set -eu

DOTFILES="$(CDPATH= cd -- "$(dirname -- "$0")/dotfiles" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

for f in .zshrc .zshenv .zprofile .profile .aliases; do
  if [ -e "$HOME/$f" ] && [ ! -L "$HOME/$f" ]; then
    mkdir -p "$BACKUP"
    mv "$HOME/$f" "$BACKUP/$f"
    echo "backed up existing $f -> $BACKUP/$f"
  fi
  ln -sfn "$DOTFILES/$f" "$HOME/$f"
  echo "linked $f"
done

if [ ! -f "$DOTFILES/env.private" ]; then
  cp "$DOTFILES/env.private.example" "$DOTFILES/env.private"
  echo "created env.private from example - fill in your keys"
fi

# Create the lowercase XDG user dirs from the tracked user-dirs.dirs. xdg-user-dirs-update
# resets any entry whose directory doesn't exist back to $HOME, so they have to exist.
USER_DIRS="$(dirname -- "$DOTFILES")/user-dirs.dirs"
while IFS= read -r line; do
  case "$line" in
    XDG_*_DIR=*)
      eval "dir=${line#*=}"
      mkdir -p "$dir"
      echo "ensured $dir"
      ;;
  esac
done < "$USER_DIRS"

# Remove the capitalized defaults a fresh install creates, but only if they're empty
for d in Desktop Downloads Templates Public Documents Music Pictures Videos Projects; do
  rmdir "$HOME/$d" 2>/dev/null && echo "removed empty $d" || true
done

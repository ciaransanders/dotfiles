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

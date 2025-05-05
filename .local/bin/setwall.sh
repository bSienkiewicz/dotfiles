#!/bin/bash

# Usage: ./setwall.sh /path/to/wallpaper.jpg

if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/wallpaper.jpg"
  exit 1
fi

WALLPAPER="$1"

# Set wallpaper with waypaper (assumes waypaper is installed and configured)
waypaper --wallpaper "$WALLPAPER"

# Generate and apply color scheme with pywal
wal -i "$WALLPAPER" --cols16

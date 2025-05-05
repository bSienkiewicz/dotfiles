#!/bin/bash

# Get the current wallpaper path from waypaper config
WALLPAPER=$(grep "wallpaper =" ~/.config/waypaper/config.ini | cut -d '=' -f2 | tr -d ' ')

# Update the hyprlock config with the current wallpaper path
sed -i "s|path = .*|path = $WALLPAPER|" ~/.config/hypr/hyprlock.conf

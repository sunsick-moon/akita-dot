#!/bin/bash
# Make and move dirs

copy_folders() {
    local f_names=(
        fastfetch fish hypr kitty mako matugen scripts superfile waybar waypaper wofi zed
    )

local failed=()

for folder in "${f_names[@]}"; do
    if
        rm -rf "$HOME/.config/$folder"
        mkdir -p "$HOME/.config/$folder" &&
        cp -a config/$folder "$HOME/.config";
        then
            echo "Copiado exitosamente: $folder"
    else
        echo "Fallo al instalar $folder"
    fi
done
cp -a config/wallpaper.png "$HOME/.config/"
}

#Config commands
chmod +x "$HOME/.config/scripts/lock.sh"
chmod +x "$HOME/.config/scripts/switch_colors.sh"
chmod +x "$HOME/.config/scripts/apply_mako.sh"

sudo gpasswd -a $USER realtime
hyprctl reload

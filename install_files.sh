#!/bin/bash
# Make and move dirs

copy_folders() {
    local f_names=(
        fastfetch gtk-3.0 gtk-4.0 hypr kitty mako scripts uwsm wal waybar waypaper wlogout wofi
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
copy_folders
wal -i "$HOME/.config/wallpaper.png"
hyprctl hyprpaper preload "~.config/wallpaper.png" && hyprctl hyprpaper wallpaper ",$HOME/.config/wallpaper.png"
chmod +x "$HOME/.config/scripts/lock.sh"
chmod +x "$HOME/.config/scripts/wal-hook.sh"
chmod +x "$HOME/.config/scripts/switch_colors.sh"
chmod +x "$HOME/.config/scripts/apply_mako.sh"

sudo gpasswd -a $USER realtime
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.nemo.desktop show-desktop-icons false
gsettings set org.cinnamon.desktop.default-applications.terminal exec 'kitty'
hyprctl reload

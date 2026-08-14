#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

copy_folders() {
    local f_names=(
        fastfetch fish gtk-3.0 gtk-4.0 hypr kitty mako matugen
        nmtui scripts superfile uwsm waybar waypaper wofi xdg-desktop-portal zed
    )

    local failed=()

    mkdir -p "$HOME/.config"

    for folder in "${f_names[@]}"; do
        if rm -rf "$HOME/.config/$folder" &&
           cp -a "$SCRIPT_DIR/config/$folder" "$HOME/.config/"; then
            echo "Copiado: $folder"
        else
            echo "Falló: $folder"
            failed+=("$folder")
        fi
    done

    if [[ -f "$SCRIPT_DIR/config/wallpaper.png" ]]; then
        cp -a "$SCRIPT_DIR/config/wallpaper.png" "$HOME/.config/"
    else
        echo "Aviso: config/wallpaper.png no encontrado, se omite."
    fi

    if ((${#failed[@]})); then
        echo
        echo "Carpetas que fallaron:"
        printf ' - %s\n' "${failed[@]}"
        return 1
    fi

    echo "Todas las carpetas se copiaron correctamente."
}

copy_folders

chmod +x "$HOME/.config/scripts/"*.sh

sudo gpasswd -a "$USER" realtime
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
systemctl --user enable --now hyprpolkitagent.service
sudo systemctl mask power-profiles-daemon
sudo systemctl stop power-profiles-daemon
sudo systemctl enable --now tuned
hyprctl reload

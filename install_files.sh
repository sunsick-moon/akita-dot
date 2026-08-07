#!/bin/bash
# Make and move dirs
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

copy_folders() {
    local f_names=(
        fastfetch fish hypr kitty mako matugen scripts superfile waybar waypaper wofi zed
    )

    local failed=()

    mkdir -p "$HOME/.config"

    for folder in "${f_names[@]}"; do
        if rm -rf "$HOME/.config/$folder" &&
           cp -a "$SCRIPT_DIR/config/$folder" "$HOME/.config/"; then
            echo "Copiado exitosamente: $folder"
        else
            echo "Fallo al instalar $folder"
            failed+=("$folder")
        fi
    done

    # Optional Wallpaper
    if [[ -f "$SCRIPT_DIR/config/wallpaper.png" ]]; then
        cp -a "$SCRIPT_DIR/config/wallpaper.png" "$HOME/.config/"
    else
        echo "Aviso: no se encontró config/wallpaper.png, se omite."
    fi

    if ((${#failed[@]})); then
        echo
        echo "Carpetas que fallaron:"
        printf ' - %s\n' "${failed[@]}"
        return 1
    fi

    echo "Todas las carpetas se copiaron correctamente."
}

# Copy folders
copy_folders

# Config commands
chmod +x "$HOME/.config/scripts/lock.sh"
chmod +x "$HOME/.config/scripts/switch_colors.sh"
chmod +x "$HOME/.config/scripts/apply_mako.sh"

sudo gpasswd -a "$USER" realtime
hyprctl reload

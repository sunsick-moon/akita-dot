#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

paquetes() {
    local pkgs=(
        ark dolphin dos2unix gnome-themes-extra grim
        hyprpolkitagent hyprpaper inter-font jq kitty
        libappindicator mako matugen nautilus superfile
        ttf-jetbrains-mono-nerd tuned uwsm nvim
        waybar waypaper wofi
        xdg-desktop-portal-gtk xdg-desktop-portal-hyprland
    )

    local failed=()

    for pkg in "${pkgs[@]}"; do
        if pacman -S --noconfirm --needed "$pkg"; then
            echo "Instalado: $pkg"
        else
            echo "Falló: $pkg"
            failed+=("$pkg")
        fi
    done

    if [[ ! -d "$HOME/.config/nvim" ]]; then
        git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
        rm -rf "$HOME/.config/nvim/.git"
    else
        echo "Aviso: ~/.config/nvim ya existe, se omite el clone de LazyVim."
    fi

    if ((${#failed[@]})); then
        echo
        echo "Paquetes que fallaron:"
        printf ' - %s\n' "${failed[@]}"
        return 1
    fi

    echo "Todos los paquetes se instalaron correctamente."
}

read -r -p "¿Actualizar sistema antes de instalar? (s/N): " r

case "${r,,}" in
    s|si|sí)
        echo "Actualizando sistema..."
        pacman -Syu --noconfirm
        ;;
    *)
        echo "Instalando sin actualizar..."
        ;;
esac

paquetes

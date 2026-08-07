#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
  exec sudo "$0" "$@"
fi

paquetes() {
    local pkgs=(
        ark dolphin hyprpaper waypaper waybar wofi inter-font mako uwsm superfile neovim ttf-jetbrains-mono-nerd libappindicator matugen dos2unix
    )

    local failed=()
    
        
    for pkg in "${pkgs[@]}"; do
        if  pacman -S --noconfirm --needed "${pkg}"; then
            echo "Instalación exitosa: $pkg"
        else
            echo "Falló el paquete $pkg, omitiendo y continuando..."
            failed+=("$pkg")
        fi
    done
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git

    if ((${#failed[@]})); then
        echo
        echo "Paquetes que fallaron:" 
        printf ' - %s\n' "${failed[@]}"
    else
        echo "Todos los paquetes se instalaron correctamente."
    fi
    
    ((${#failed[@]})) && return 1 || return 0

}

read -r -p "Preparando instalación... ¿Ejecutar actualización del sistema (1) o instalar directamente (2) (1/2): " r

case "$r" in
  1)
    echo "Actualizando sistema, luego instalando..."
     pacman -Syu --noconfirm
    paquetes
    ;;

  2|"")
    echo "Instalando directamente con los paquetes y BD actuales..."
    paquetes

    ;;
    *)
    echo "Opción inválida"
    exit 1
    ;;
esac

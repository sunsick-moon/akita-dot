#!/bin/bash
set -e

# IMPORTANTE: este script ya NO se vuelve a ejecutar completo como root.
# Escalamos con `sudo` solo en los comandos puntuales que lo necesitan
# (pacman, systemctl, gpasswd...). Si todo el script corriera como root,
# $HOME pasaría a ser /root (comportamiento por defecto de sudo en Arch) y
# cosas como el clone de LazyVim o los plugins de fish terminarían
# instalados para el usuario root en vez de para ti.
if [[ $EUID -eq 0 ]]; then
    echo "No ejecutes este script como root/con sudo directamente." >&2
    echo "Ejecútalo como tu usuario normal; se te pedirá la contraseña cuando haga falta." >&2
    exit 1
fi

paquetes() {
    local pkgs=(
        # Hyprland ecosystem (hyprland/sddm se preguntan aparte, ver más abajo)
        hypridle hyprlock hyprpaper hyprpolkitagent hyprshutdown
        hyprland-qt-support xdg-desktop-portal-hyprland xdg-desktop-portal-gtk

        # Audio (Pipewire + Wireplumber: sin esto no hay sonido en Hyprland)
        # realtime-privileges crea el grupo "realtime" que install_files.sh
        # usa para darte prioridad de audio en tiempo real.
        pipewire pipewire-alsa pipewire-pulse realtime-privileges wireplumber

        # Apps y utilidades base de la rice
        ark bat dolphin dos2unix eza fastfetch fish git gnome-themes-extra
        grim inter-font jq kitty libappindicator mako matugen nautilus
        networkmanager nvim reflector slurp superfile tuned uwsm waybar
        waypaper wl-clipboard wofi

        # Teclado multimedia / brillo / reproductores (usados en input_mapping.lua)
        brightnessctl playerctl

        # Theming GTK/Qt consistente (adw-gtk3 para gtk-3.0, qt6ct para Qt)
        adw-gtk-theme qt5-wayland qt6-wayland qt6ct

        # Fuentes: nerd font + fallback de glifos/emoji para que no salgan
        # cuadraditos en vez de iconos (ver "Squares instead of text" en la
        # ArchWiki de Hyprland)
        noto-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols

        # Varios
        xdg-user-dirs
    )

    local failed=()

    for pkg in "${pkgs[@]}"; do
        if sudo pacman -S --noconfirm --needed "$pkg"; then
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

# Instala un paquete solo si no está ya presente, preguntando antes.
# Esto es lo que pide la tarea para Hyprland y SDDM: si ya los tienes
# (por ejemplo vienes de una distro que ya trae Hyprland, o usas otro DM),
# el script no toca nada; si no los tiene, te deja decidir.
install_optional() {
    local label="$1" pkg="$2"

    if pacman -Qq "$pkg" &>/dev/null; then
        echo "$label ya está instalado ($pkg), se omite."
        return 0
    fi

    local r
    read -r -p "$label no se encontró en el sistema. ¿Instalar $pkg? (s/N): " r
    case "${r,,}" in
        s | si | sí)
            if sudo pacman -S --noconfirm --needed "$pkg"; then
                echo "Instalado: $pkg"
                return 0
            else
                echo "Falló: $pkg"
                return 1
            fi
            ;;
        *)
            echo "Omitiendo instalación de $label."
            return 0
            ;;
    esac
}

# Fisher + plugins de fish (pure prompt + done) usados por config/fish.
# Se ejecuta como tu usuario, nunca como root.
fish_plugins() {
    if ! command -v fish &>/dev/null; then
        echo "Aviso: fish no está instalado, se omiten sus plugins."
        return
    fi

    if ! fish -c 'type -q fisher' &>/dev/null; then
        echo "Instalando fisher (gestor de plugins de fish)..."
        fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher' \
            || { echo "Falló la instalación de fisher."; return 1; }
    fi

    echo "Instalando plugins de fish (pure, done)..."
    fish -c 'fisher install pure-fish/pure jorgebucaran/done' \
        || echo "Aviso: no se pudieron instalar los plugins de fish (pure/done)."
}

read -r -p "¿Actualizar sistema antes de instalar? (s/N): " r

case "${r,,}" in
    s | si | sí)
        echo "Actualizando sistema..."
        sudo pacman -Syu --noconfirm
        ;;
    *)
        echo "Instalando sin actualizar..."
        ;;
esac

# No usamos `set -e` aquí: si un paquete falla queremos seguir con el resto
# del script (Hyprland/SDDM opcionales, plugins de fish) en vez de abortar.
paquetes || echo "Aviso: algunos paquetes fallaron, revisa el listado de arriba."

echo
install_optional "Hyprland" hyprland

echo
if install_optional "SDDM" sddm; then
    if pacman -Qq sddm &>/dev/null; then
        read -r -p "¿Habilitar SDDM como gestor de sesión (systemctl enable sddm)? (s/N): " r
        case "${r,,}" in
            s | si | sí) sudo systemctl enable sddm.service ;;
            *) echo "Omitiendo habilitación de SDDM." ;;
        esac
    fi
fi

echo
fish_plugins

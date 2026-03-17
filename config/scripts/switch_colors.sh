#!/bin/bash

WALLPAPER_PATH="$1"

if [ -z "$WALLPAPER_PATH" ]; then
    echo "No se proporcionó una ruta de fondo de pantalla."
    exit 1
fi

HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
MONITOR=$(hyprctl monitors -j | jq -r '.[0].name')

echo "Ejecutando Pywal en: $WALLPAPER_PATH" > /tmp/wal-hook.log
wal -i "$WALLPAPER_PATH" -n -q
echo "Pywal finalizado." >> /tmp/wal-hook.log

# Crear nueva config compatible con hyprpaper moderno
cat > "$HYPRPAPER_CONF" <<EOF
wallpaper {
    monitor = $MONITOR
    path = $WALLPAPER_PATH
    fit_mode = cover
}
splash = false
EOF

echo "hyprpaper.conf actualizado con $WALLPAPER_PATH" >> /tmp/wal-hook.log

# recargar hyprpaper
killall hyprpaper
hyprpaper &

sh "$HOME/.config/scripts/apply_mako.sh"

exit 0

#!/bin/bash
WALLPAPER_PATH="$1"

if [ -z "$WALLPAPER_PATH" ]; then
    echo "No se proporcionó una ruta de fondo de pantalla."
    exit 1
fi

echo "Ejecutando Pywal en: $WALLPAPER_PATH" > /tmp/wal-hook.log
wal -i "$WALLPAPER_PATH" -n -q

echo "Pywal finalizado." >> /tmp/wal-hook.log


exit 0

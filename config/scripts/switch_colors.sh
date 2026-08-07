#!/bin/bash
set -euo pipefail

WALLPAPER_PATH="$1"
LOG_FILE="/tmp/matugen-hook.log"

# 1. Validar argumento
if [ -z "$WALLPAPER_PATH" ] || [ ! -f "$WALLPAPER_PATH" ]; then
    echo "[ERROR] No se proporcionó una ruta de fondo de pantalla válida." | tee -a "$LOG_FILE"
    exit 1
fi

echo "=== Inicio de actualización: $(date) ===" > "$LOG_FILE"

# 2. Generar esquemas de colores con Matugen
echo "Ejecutando Matugen..." >> "$LOG_FILE"
matugen image "$WALLPAPER_PATH" --prefer=saturation >> "$LOG_FILE" 2>&1 || true

# 3. Guardar configuración persistente (SIEMPRE antes de iniciar o recargar hyprpaper)
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
mkdir -p "$(dirname "$HYPRPAPER_CONF")"

cat > "$HYPRPAPER_CONF" <<EOF
preload = $WALLPAPER_PATH
wallpaper = ,$WALLPAPER_PATH
splash = false
ipc = on
EOF

# 4. Aplicar Wallpaper en caliente con Hyprpaper
echo "Actualizando Hyprpaper dinámicamente..." >> "$LOG_FILE"
if pgrep -x hyprpaper > /dev/null; then
    # Precargar nueva imagen en RAM
    hyprctl hyprpaper preload "$WALLPAPER_PATH" >> "$LOG_FILE" 2>&1

    # Asignar a TODOS los monitores (la coma inicial ',/path' equivale a 'all monitors')
    hyprctl hyprpaper wallpaper ",$WALLPAPER_PATH" >> "$LOG_FILE" 2>&1

    # Liberar imágenes antiguas no utilizadas de la memoria
    hyprctl hyprpaper unload unused >> "$LOG_FILE" 2>&1
else
    # Si no estaba corriendo, se inicia leyendo la configuración recién creada
    hyprpaper &
fi

# 5. Forzar recarga en caliente de Kitty Terminal
if pgrep -x kitty > /dev/null; then
    echo "Recargando colores en Kitty..." >> "$LOG_FILE"
    touch "$HOME/.config/kitty/kitty.conf"
    pkill -USR1 kitty || true
fi

# 6. Aplicar Mako
MAKO_SCRIPT="$HOME/.config/scripts/apply_mako.sh"
if [ -f "$MAKO_SCRIPT" ]; then
    echo "Ejecutando script de Mako..." >> "$LOG_FILE"
    bash "$MAKO_SCRIPT" >> "$LOG_FILE" 2>&1
fi

echo "=== Proceso finalizado con éxito ===" >> "$LOG_FILE"
exit 0

#!/usr/bin/env bash
set -euo pipefail

# Archivo generado por la plantilla de Matugen
MATUGEN_OUT="$HOME/.config/matugen/generated/mako"

# Archivo real de configuración de Mako
MAKO_CFG="$HOME/.config/mako/config"

mkdir -p "$(dirname "$MAKO_CFG")"

if [[ ! -f "$MATUGEN_OUT" ]]; then
  echo "No existe $MATUGEN_OUT. Ejecuta 'matugen image ...' primero para generar el template."
  exit 1
fi

cp -f "$MATUGEN_OUT" "$MAKO_CFG"

# Recarga la configuración de Mako al vuelo
if command -v makoctl &> /dev/null; then
  makoctl reload
else
  pkill -USR1 mako || true
fi

#!/usr/bin/env bash
set -euo pipefail

WAL_OUT="$HOME/.cache/wal/mako"

# Archivo real que usa mako normalmente
MAKO_CFG="$HOME/.config/mako/config"

mkdir -p "$(dirname "$MAKO_CFG")"

if [[ ! -f "$WAL_OUT" ]]; then
  echo "No existe $WAL_OUT. Ejecuta 'wal -i ...' primero para generar el template."
  exit 1
fi

cp -f "$WAL_OUT" "$MAKO_CFG"

# Recarga sin reiniciar
pkill -USR1 mako || true

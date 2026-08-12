#!/bin/bash

current=$(tuned-adm active | awk '{print $4}')

case "$current" in
    "desktop"|"throughput-performance"|"accelerator-performance")
        echo "󰓅 $current"  # Icono de cohete / rendimiento
        ;;
    "powersave"|"laptop-battery-powersave")
        echo "󰌪 $current"  # Icono de hoja / ahorro
        ;;
    *)
        echo "󰾆 $current"  # Icono de balanza / equilibrado
        ;;
esac
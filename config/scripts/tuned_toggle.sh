#!/bin/bash

# Obtener el perfil activo actual de tuned
current=$(tuned-adm active | awk '{print $4}')

# Definir el ciclo de perfiles que quieres alternar con un solo clic
case "$current" in
    "balanced")
        tuned-adm profile desktop
        notify-send "TuneD" "Perfil: Desktop (Rendimiento)" -t 2000
        ;;
    "desktop")
        tuned-adm profile powersave
        notify-send "TuneD" "Perfil: Powersave (Ahorro)" -t 2000
        ;;
    *)
        tuned-adm profile balanced
        notify-send "TuneD" "Perfil: Balanced (Equilibrado)" -t 2000
        ;;
esac
#!/bin/bash

STATE_FILE="/tmp/waybar-powermenu-state"

declare -A ACTIONS=(
    ["logout"]="󰍃 :uwsm stop"
    ["lock"]="󰌾 :hyprlock"
    ["reboot"]="󰑓 :systemctl reboot"
    ["power"]="󰐥 :systemctl poweroff"
    ["sleep"]="󰒲 :systemctl suspend"
)

ORDER=("logout" "lock" "reboot" "power" "sleep")

if [ ! -f "$STATE_FILE" ]; then
    echo "logout" > "$STATE_FILE"
fi

current=$(cat "$STATE_FILE")

get_index() {
    for i in "${!ORDER[@]}"; do
        if [[ "${ORDER[$i]}" = "${1}" ]]; then
            echo "$i"
            return
        fi
    done
    echo 0
}

case "$1" in
    "next")
        idx=$(get_index "$current")
        next_idx=$(( (idx + 1) % ${#ORDER[@]} ))
        echo "${ORDER[$next_idx]}" > "$STATE_FILE"
        pkill -SIGRTMIN+8 waybar
        ;;
    "prev")
        idx=$(get_index "$current")
        prev_idx=$(( (idx - 1 + ${#ORDER[@]}) % ${#ORDER[@]} ))
        echo "${ORDER[$prev_idx]}" > "$STATE_FILE"
        pkill -SIGRTMIN+8 waybar
        ;;
    "exec")
        IFS=":" read -r icon cmd <<< "${ACTIONS[$current]}"
        eval "$cmd"
        ;;
    *)
        IFS=":" read -r icon cmd <<< "${ACTIONS[$current]}"
        printf '{"text": "%s", "tooltip": "Acción: %s\\n(Usa scroll para cambiar)"}\n' "$icon" "$current"
        ;;
esac
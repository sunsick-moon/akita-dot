#!/bin/bash

current=$(tuned-adm active | awk '{print $4}')

case "$current" in
    "desktop"|"throughput-performance"|"accelerator-performance")
        echo "󰓅 $current"
        ;;
    "powersave"|"laptop-battery-powersave")
        echo "󰌪 $current"
        ;;
    *)
        echo "󰾆 $current"
        ;;
esac
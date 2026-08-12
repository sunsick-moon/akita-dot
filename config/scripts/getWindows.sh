#!/bin/bash

WS=$(hyprctl -j activeworkspace | jq '.id')

hyprctl -j clients | jq -r --argjson ws "$WS" '
    map(select(.workspace.id == $ws))
    | map(
        if .class == "kitty" then "Kitty"
        elif .class == "org.kde.dolphin" then "Dolphin"
        elif .class == "firefox" then "Firefox"
        elif .class == "spf" then "Superfile"
        elif .class == "dev.zed.Zed" then "Zed"
        elif .class == "org.telegram.desktop" then "Telegram"
        elif .class == "codium" then "VSCodium"
        
        else .title
        end
    )
    | "\(join(" │ ")) │ (\(length))"
'

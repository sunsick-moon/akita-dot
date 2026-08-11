#!/bin/bash

WS=$(hyprctl -j activeworkspace | jq '.id')

hyprctl -j clients | jq -r --argjson ws "$WS" '
    map(select(.workspace.id == $ws))
    | map(
        if .class == "kitty" then "terminal"
        elif .class == "org.kde.dolphin" then "dolphin"
        elif .class == "firefox" then "browser"
        elif .class == "spf" then "superfile"
        elif .class == "dev.zed.Zed" then "zed"
        else .class
        end
    )
    | "\(join(" │ ")) │ (\(length))"
'

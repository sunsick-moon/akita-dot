--- Apps and stuff ---
local apps = {}
apps.run = "uwsm app -- "
apps.terminal = apps.run .. "kitty"
apps.menu = apps.run .. "wofi --show drun"
apps.files = apps.run .. "dolphin"
apps.statusbar = apps.run .. "waybar"
apps.spf = apps.run.. "kitty -e spf"

return apps

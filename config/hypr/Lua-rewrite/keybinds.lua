-- Main input key
require(apps)
local metaKey = "SUPER"

-- Keybindings
hl.bind(metaKey .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(metaKey .. " + Q", hl.dsp.window.close())
hl.bind(metaKey .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(metaKey .. " + E", hl.dsp.exec_cmd(files))
hl.bind(metaKey .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(metaKey .. " + space", hl.dsp.exec_cmd(menu))


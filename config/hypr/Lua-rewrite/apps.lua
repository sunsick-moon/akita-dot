-- Enviroments variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Local apps
local terminal = "kitty"
local files = "dolphin"
local menu = "wofi"
local firefox = "firefox"

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd(terminal)
    hl.exec_cmd(firefox)
end)


--- Keybinds ---
local App = require("app_vars")

local Main = "SUPER"
hl.bind(Main .. " + return", hl.dsp.exec_cmd(App.terminal))
hl.bind(Main .. " + space", hl.dsp.exec_cmd(App.menu))
hl.bind(Main .. " + Q", hl.dsp.window.close())
hl.bind(Main .. " + E", hl.dsp.exec_cmd(App.files))
hl.bind(Main .. " + K", hl.dsp.exec_cmd(App.spf))
hl.bind(Main .. " + backspace",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(Main .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(Main .. " + P", hl.dsp.window.pseudo())

-- Workspaces enumeration
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(Main .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(Main .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move focus with mainMod + arrow keys
hl.bind(Main .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(Main .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(Main .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(Main .. " + down", hl.dsp.focus({ direction = "down" }))

--###### And the rest or whatever #####--
-- Example special workspace (scratchpad)
hl.bind(Main .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(Main .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(Main .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(Main .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(Main .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(Main .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

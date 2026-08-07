local Apps = require("app_vars")

----  Autostart ----
hl.on("hyprland.start", function ()
    hl.exec_cmd(Apps.terminal)
    hl.exec_cmd(Apps.statusbar)
    hl.exec_cmd("waypaper --restore")
    --hl.exec_cmd("nm-applet")
    --hl.exec_cmd("waybar & hyprpaper & firefox")
end)

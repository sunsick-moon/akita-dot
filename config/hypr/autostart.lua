local Apps = require("app_vars")

----  Autostart ----
hl.on("hyprland.start", function ()
    hl.exec_cmd(Apps.terminal)
    hl.exec_cmd(Apps.statusbar)
    hl.exec_cmd(Apps.notify)
    hl.exec_cmd("waypaper --restore")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    
end)

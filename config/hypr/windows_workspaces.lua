---- Windows and workspaces ----

hl.window_rule({
    match = {
        class = "^org.kde.dolphin$",
    },
    tag = "+filemanager",
})

hl.window_rule({
    match = {
        class = "^spf$",
    },
    tag = "+filemanager",
})

hl.window_rule({
    match = {
        class = "^org.gnome.Nautilus$",
    },
    tag = "+filemanager",
})

hl.window_rule({
    match = {  tag = "filemanager", },
    float = true,
    center = true,
    size = {"(monitor_w*0.85)", "(monitor_h*0.75)"}
})

hl.window_rule({
    match = {  class = "xdg-desktop-portal-gtk", },
    float = true,
    center = true,
    size = {"(monitor_w*0.85)", "(monitor_h*0.75)"}
})

hl.window_rule({
    match = {  class = "filemanager", },
    float = true,
    center = true,
    size = {"(monitor_w*0.85)", "(monitor_h*0.75)"}
})





















-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

-- hl.window_rule({
--     match = {
--         class = "org.kde.dolphin",
--     },
--     float = true,
--     pin = true,
-- })

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

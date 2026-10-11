--- Misc ---

hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

hl.layer_rule({
    match = { namespace = "wofi" },
    animation = "fade"
})

-- Community fix: XWayland apps (and some Electron/Chromium windows that fall
-- back to XWayland) look pixelated/blurry on scaled monitors because Xorg
-- itself cannot scale. Forcing zero scaling renders XWayland at 1x and lets
-- Hyprland upscale it like any other surface, which looks far sharper than
-- Xorg's own (terrible) scaling.
-- See: https://wiki.hypr.land/Configuring/Advanced-and-Cool/XWayland/
-- If you run a scaled monitor (see monitors.lua) you may also want to set
-- toolkit-specific scaling (GDK_SCALE, QT_SCALE_FACTOR, XCURSOR_SIZE) in
-- ~/.config/uwsm/env, since this setting alone does not resize XWayland apps.
hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

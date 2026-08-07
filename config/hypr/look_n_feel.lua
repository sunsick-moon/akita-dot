----  Look and Feel ----
local colors = require("colors")

hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 5,

        border_size      = 2,

        col              = {
            active_border = colors.active_border,
            inactive_border = colors.inactive_border,
        },

        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,

        layout           = "dwindle",
    },

    decoration = {
        rounding         = 7,
        rounding_power   = 1.5,

        active_opacity   = 0.93,
        inactive_opacity = 0.90,

        shadow           = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur             = {
            enabled  = true,
            size     = 12,
            passes   = 2,
            vibrancy = 1,
        },
    },
})

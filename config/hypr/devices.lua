--- ### Input ### ---

--Keyboard setup
hl.config({
    input = {
        kb_layout  = "latam",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
    },
})

-- Mouse
hl.config({
    input = {
        follow_mouse = 1,

        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad     = {
            natural_scroll = false,
        },
    },
})

-- Touchpad gestures
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

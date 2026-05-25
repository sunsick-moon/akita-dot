-- Input layout
hl.config({
    input = {
        kb_layout  = "latam",

        follow_mouse = 1,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Custom devices
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})
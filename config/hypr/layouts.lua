--- Custom Layouts ---

hl.config({
    general = {
       layout = "scrolling" 
    },
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 1.0,
        direction = "right"
    }
})

local function waybar_refresh()
    hl.exec_cmd("pkill -RTMIN+8 waybar")
end

hl.on("window.open", waybar_refresh)
hl.on("window.destroy", waybar_refresh)
hl.on("window.move_to_workspace", waybar_refresh)
hl.on("workspace.active", waybar_refresh)


-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
-- hl.config({
--     dwindle = {
--         preserve_split = true, -- You probably want this
--     },
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
-- hl.config({
--     master = {
--         new_status = "master",
--     },
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
-- hl.config({
--     scrolling = {
--         fullscreen_on_one_column = true,
--     },
-- })

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
    match = {  tag = "filemanager", },
    float = true,
    center = true,
    size = {"(monitor_w*0.85)", "(monitor_h*0.75)"}
})

hl.window_rule({
    match = {  class = "nmtui-popup", },
    float = true,
    center = true,
    size = {"(monitor_w*0.4)", "(monitor_h*0.70)"}
})



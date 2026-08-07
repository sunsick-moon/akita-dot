--- Animations settings ---

hl.config ({
    animations = {
        enabled = true,
    }
})

--0.37, 0, 0.63, 1) { 0.23, 1 }, { 0.32, 1 }
hl.curve("Pepe", { type = "bezier", points = { { 0.37, 0 }, { 0.63, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "Pepe", style = "popin 10%"})
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "Pepe", style = "popin 10%"})
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "Pepe", style = "popin 10%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed =1, bezier = "Pepe", style = "slide" })

hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "Pepe" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "Pepe" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 2.7, bezier = "Pepe", style = "fade" })

---hl.animation({
---    leaf = "layers",
---    enabled = true,
---    speed = 1,
---    bezier = "Pepe",
---    style = "fade"
---})

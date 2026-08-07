-- ~/.config/matugen/templates/colors.lua
return {
    primary = "{{ colors.primary.default.hex_stripped }}",
    secondary = "{{ colors.secondary.default.hex_stripped }}",
    tertiary = "{{ colors.tertiary.default.hex_stripped }}",
    surface = "{{ colors.surface.default.hex_stripped }}",
    surface_variant = "{{ colors.surface_variant.default.hex_stripped }}",
    outline = "{{ colors.outline.default.hex_stripped }}",

    -- Colores formateados listos para los bordes de Hyprland
    active_border = "rgba({{ colors.primary.default.hex_stripped }}ff)",
    inactive_border = "rgba({{ colors.surface_variant.default.hex_stripped }}ff)",
}

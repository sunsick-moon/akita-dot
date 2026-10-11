# akita-dot 🐕

My own custom rice of Hyprland based on the wallpapers colors!

Built on plain Arch Linux + [uwsm](https://github.com/Vladimir-csp/uwsm), using Hyprland's
Lua configuration (0.55+). It doesn't require CachyOS or any of its packages.

# Installation

1. Apply **chmod +x** to `install_dependencies.sh` and `install_files.sh`.
2. Run **install_dependencies.sh** to install required packages. Run it as your
   normal user (not with `sudo`) — it will ask for your password whenever it
   actually needs root.
   - You'll be asked whether to install **Hyprland** and **SDDM** only if they
     aren't already on your system, so this is safe to run even if you're
     already on a Hyprland-based distro or prefer a different display manager.
3. Finally, run **install_files.sh** to install the config.

## Important ⚠️

- **Installing the config will delete your previous `.config` folders for
  every component listed in `install_files.sh`. Please consider doing a
  backup first!**
- **Don't forget to edit the env variables (`.config/uwsm/env` and
  `.config/uwsm/env-hyprland`) and the monitor config (`.config/hypr/monitors.lua`)
  to adjust your experience based on the hardware you have.**
- No wallpaper is bundled or hardcoded. Pick one with `waypaper` (autostarted)
  or `~/.config/scripts/switch_colors.sh <path-to-image>`, which also
  regenerates your Material You color scheme via matugen.

## What's in here

- **Hyprland** (Lua config, split across `config/hypr/*.lua`), with `hypridle`
  - `hyprlock` for idle/locking and `hyprshutdown` for a clean power menu.
- **uwsm** session management — see the note below.
- **waybar**, **mako**, **wofi**, **kitty**, **fish**, **fastfetch**, **gtk**,
  **superfile**, **nmtui**, all themed dynamically from your wallpaper via
  **matugen**.

## uwsm

This config is started through `uwsm`, so a couple of rules apply:

- Never bind Hyprland's own `exit` dispatcher, and don't kill the compositor
  process directly — it skips uwsm's ordered shutdown. The power menu
  (`scripts/power_toggle.sh`) already uses `uwsm stop`, and the Super+Backspace
  keybind falls back to it if `hyprshutdown` isn't installed.
- Environment variables go in `~/.config/uwsm/env` (shared by any uwsm
  session) or `~/.config/uwsm/env-hyprland` (Hyprland-only `HYPR_*`/`AQ_*`
  vars), not inside `hyprland.lua`.

## Hyprland community fixes included

- **Chromium/Electron apps look blurry or run native-Wayland-broken**:
  `ELECTRON_OZONE_PLATFORM_HINT=auto` and `MOZ_ENABLE_WAYLAND=1` are set in
  `uwsm/env`. Apps that bundle their own Electron (Discord, Spotify, …) need
  their `.desktop` file or `*-flags.conf` patched manually — see the comments
  in `uwsm/env`.
- **Fuzzy/pixelated XWayland apps and font rendering**: `xwayland.force_zero_scaling`
  is enabled in `hypr/misc.lua`, matching the current Hyprland wiki guidance.
- **XWayland/JetBrains apps stealing focus on popups/drags**: a
  `no_initial_focus` window rule for all XWayland windows, as documented on
  the Arch Wiki Hyprland page.

## Fastfetch & fish

Previous versions relied on `cachyos-fish-config`, a package that only exists
on CachyOS. `config/fish/config.fish` is now self-contained (fastfetch
greeting, `eza`/`bat`-based aliases, generic Arch maintenance aliases) and
`install_dependencies.sh` bootstraps `fisher` plus the `pure` prompt and
`done` notification plugins it expects.

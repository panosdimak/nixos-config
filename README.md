# NixOS Configuration

<table>
<tr><td><b>WM</b></td><td>Hyprland</td></tr>
<tr><td><b>Desktop Shell</b></td><td>DankMaterialShell</td></tr>
<tr><td><b>DM</b></td><td>GDM</td></tr>
<tr><td><b>Lock Screen</b></td><td>Hyprlock</td></tr>
<tr><td><b>Launcher</b></td><td>Vicinae</td></tr>
<tr><td><b>File Manager</b></td><td>Nautilus</td></tr>
<tr><td><b>Terminal</b></td><td>Kitty</td></tr>
<tr><td><b>Shell</b></td><td>Bash + Starship + FZF</td></tr>
<tr><td><b>Editor</b></td><td>Neovim · Zed</td></tr>
<tr><td><b>Browser</b></td><td>Zen</td></tr>
<tr><td><b>Theming</b></td><td>Matugen (wallpaper-based dynamic colors) + Stylix (fonts)</td></tr>
</table>

## Features

- **Two hosts** — `ryzen-desktop` (AMD/NVIDIA) and `inspiron-15` (Intel laptop) with shared modules and per-host overrides
- **Music production** — low-latency PipeWire via Musnix, REAPER, Yabridge for Windows VSTs
- **Dynamic theming** — wallpaper-driven color generation across the entire desktop (see below)
- **Direnv integration**

## Structure

```
.
├── flake.nix                       # Entrypoint — inputs, hosts, overlays
├── nixos/
│   ├── hosts/
│   │   ├── ryzen-desktop/          # AMD desktop + NVIDIA + music production
│   │   └── inspiron-15/            # Intel laptop + power management
│   ├── modules/                    # System modules (boot, audio, networking, …)
│   └── profiles/common.nix         # Shared module bundle for all hosts
├── home/
│   ├── common.nix                  # Shared HM module imports
│   ├── default.nix                 # Common packages & session vars
│   ├── ryzen-desktop.nix           # Desktop-specific HM overrides
│   ├── inspiron-15.nix             # Laptop-specific HM overrides
│   └── modules/                    # HM modules (hyprland, neovim, waybar, …)
│       └── matugen/                # Dynamic color generation from wallpaper
├── shells/                         # Dev environments (rust, python, opengl)
└── scripts/                        # Utilities (wallpaper-theme.sh)
```

## Theming

[Matugen](https://github.com/InioX/matugen) generates Material You colors from the current wallpaper and applies them across the desktop — Hyprland, DankMaterialShell, Fuzzel, Kitty, Neovim, Zed, Vicinae, Vesktop, GTK, and Starship all have matugen templates with fallback colors for first boot. DMS handles wallpaper selection natively. Fonts are managed separately through Stylix.

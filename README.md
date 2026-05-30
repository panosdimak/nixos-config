# NixOS Config

My personal flake. Two hosts sharing a Hyprland + DankMaterialShell desktop.

- `ryzen-desktop`: AMD + NVIDIA
- `inspiron-15`: Intel laptop

## Stack

| | |
|---|---|
| Compositor | Hyprland |
| Shell      | DankMaterialShell |
| Login      | GDM |
| Launcher   | Vicinae |
| Terminal   | Kitty, Bash + Starship + FZF |
| Editor     | Neovim, Zed |
| Browser    | Zen |
| Theming    | Matugen |
| Audio      | PipeWire + Musnix |

## Layout

```
flake.nix              inputs, hosts, overlays
nixos/
  hosts/<host>/        hardware + module selection
  modules/             system modules (boot, audio, nvidia, dms, ...)
  profiles/common.nix  shared module bundle
home/
  modules/             home-manager modules
  modules/matugen/     color templates, one per app
  <host>.nix           per-host HM overrides
shells/                direnv dev environments (rust, python, java, opengl)
```

## Worth a look

- `home/modules/matugen/`: wallpaper to colors pipeline, one template per app, fallback Catppuccin on first boot, live reload via post hooks.
- `flake.nix` + `nixos/profiles/common.nix`: multi host layout (Home Manager wired in as a NixOS module, shared profile, per host overrides).
- `nixos/modules/dms.nix` and `home/modules/hyprland.nix`: working DankMaterialShell setup, plus [`quickshell-overview`](https://github.com/Shanu-Kumawat/quickshell-overview) wired in as its own QS daemon to replace DMS's broken Hyprland overview.

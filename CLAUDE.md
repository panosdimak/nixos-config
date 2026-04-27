# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Deploy

```bash
# Rebuild and switch (pick the appropriate host)
sudo nixos-rebuild switch --flake .#$(hostname)

# Check flake evaluation correctness (preferred over nixos-rebuild build)
nix flake check

# Update flake inputs
nix flake update

# Format Nix files (project uses alejandra)
alejandra .
```

## Architecture

This is a NixOS flake managing two hosts with shared modules and per-host overrides.

**Flake structure:** `flake.nix` defines two `nixosConfigurations` (`ryzen-desktop`, `inspiron-15`). Both share `commonModules` (home-manager, stylix, musnix) and use `mkHome` to wire Home Manager as a NixOS module (not standalone). The `inputs` follow nixpkgs-unstable; Hyprland and Quickshell use their own nixpkgs.

**System layer** (`nixos/`):
- `profiles/common.nix` — imports all shared system modules
- `modules/` — individual concerns (boot, audio, networking, nvidia, etc.)
- `modules/dms.nix` — DankMaterialShell (DMS) via Quickshell, providing the status bar, notification center, and overview for all hosts
- `hosts/<name>/` — host-specific hardware config and module selection (e.g. ryzen-desktop enables nvidia + musnix, inspiron-15 enables power-management)

**Home layer** (`home/`):
- `common.nix` — imports all shared HM modules from `modules/`
- `default.nix` — shared packages and session variables
- `<host>.nix` — per-host HM overrides
- `modules/` — individual HM modules (hyprland, waybar, neovim, etc.)
- `modules/matugen/` — dynamic wallpaper-to-color theming with templates for each app and post-hooks for live reload

**Theming:** Two systems work together — **Stylix** manages fonts and base16 color scheme per host, **matugen** generates runtime colors from the current wallpaper. Matugen templates live in `home/modules/matugen/` with one `.nix` file per target app (including `quickshell.nix` for DMS colors).

**Dev shells** (`shells/`): Standalone flakes for rust, python, java, opengl — used via direnv.

**Scripts** (`scripts/`): Utility scripts (wallpaper-theme.sh is legacy; DMS now handles wallpaper selection and triggers matugen natively).

## Installing Windows VST Plugins

Windows VST installers (InnoSetup `.exe`) can't run reliably under Wine's wow64 mode due to missing `cryptbase.dll`. Use `innoextract` instead:

```bash
# 1. Extract the installer (if split RAR, extract that first with unrar)
nix-shell -p innoextract --run "innoextract -d /tmp/pluginname 'Setup Plugin.exe'"

# 2. Copy plugin files to the yabridge-managed directory
cp /tmp/pluginname/code\$GetDir\$VST3x64/*.vst3 "/data/Downloads/VSTPlugins/"
cp /tmp/pluginname/code\$GetDir\$VST2x64/*.dll "/data/Downloads/VSTPlugins/"

# 3. Copy presets/data if present
cp -r /tmp/pluginname/commonappdata/* ~/.wine/drive_c/ProgramData/

# 4. Sync yabridge
yabridgectl sync
```

Plugin search path for yabridge: `/data/Downloads/VSTPlugins/` (Neural DSP plugins go in the `Neural DSP/` subdirectory).

## Conventions

- Nix formatter: `alejandra` (no trailing commas, no semicolons after `in`)
- State version: 25.05 for both hosts
- All flake inputs except hyprland follow `nixpkgs`
- `ryzen-desktop` has a yabridge overlay pinned to a specific nixpkgs commit for Wine compatibility
- Home Manager is integrated as a NixOS module (`home-manager.nixosModules.home-manager`), not used standalone

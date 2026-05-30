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

This is a NixOS flake managing two hosts with shared modules and per-host overrides. **Hyprland** is the Wayland compositor; **DankMaterialShell (DMS)** — a Quickshell QML frontend with a Go backend (`dgop` for telemetry, `dms` CLI tools) — is the desktop shell layered on top.

**Flake structure:** `flake.nix` defines two `nixosConfigurations` (`ryzen-desktop`, `inspiron-15`). Both share `commonModules` (home-manager, musnix) and use `mkHome` to wire Home Manager as a NixOS module (not standalone). The `inputs` follow nixpkgs-unstable; Hyprland and Quickshell use their own nixpkgs.

**System layer** (`nixos/`):
- `profiles/common.nix` — imports all shared system modules
- `modules/` — individual concerns (boot, audio, networking, nvidia, etc.)
- `modules/dms.nix` — DankMaterialShell (DMS) via Quickshell, providing the status bar and notification center for all hosts. The workspace overview is **not** DMS's — it's the standalone `quickshell-overview` (see Home layer)
- `hosts/<name>/` — host-specific hardware config and module selection (e.g. ryzen-desktop enables nvidia + musnix, inspiron-15 enables power-management)

**Home layer** (`home/`):
- `common.nix` — imports all shared HM modules from `modules/`
- `default.nix` — shared packages and session variables
- `<host>.nix` — per-host HM overrides
- `modules/` — individual HM modules (hyprland, waybar, neovim, etc.)
- `modules/matugen/` — dynamic wallpaper-to-color theming with templates for each app and post-hooks for live reload

**Theming:** **matugen** generates runtime colors from the current wallpaper. Templates live in `home/modules/matugen/` with one `.nix` file per target app (including `quickshell.nix` for DMS colors). Fonts are configured in `nixos/modules/fonts.nix` (Stylix was removed — apps consume matugen-rendered colors directly, no base16 layer).

**Workspace overview:** The `quickshell-overview` flake input (Shanu-Kumawat/quickshell-overview, `flake = false`) is symlinked into `~/.config/quickshell/overview` by `home/modules/hyprland.nix`. It runs as its own QS daemon (`qs -c overview`, started via exec-once) and is toggled by Super+Tab → `qs ipc -c overview call overview toggle`. Per-user options (e.g. `showSpecialWorkspaces`, `colorSource: matugen`) live in `~/.config/quickshell/overview/config.json` — that file is **not** version-controlled. Matugen colors are sourced from `home/modules/matugen/quickshell.nix` which renders to `~/.config/quickshell/overview/common/Appearance.colors.qml`. Preferred over DMS's overview (broken on Hyprland — focus-grab race with workspace dispatch, `DMS_HYPRLAND_EXCLUSIVE_FOCUS=1` is a partial workaround) and over hyprtasking (also unreliable). Do not suggest switching back without a strong reason.

**Zen browser icon:** `home/default.nix` symlinks `zen-browser.svg` from `fluent-icon-theme` into hicolor because the `zen-twilight.desktop` entry declares `Icon=zen-browser` and quickshell-overview resolves icons strictly by that name (no class fallback like DMS).

**Dev shells** (`shells/`): Standalone flakes for rust, python, java, opengl — used via direnv.

**Scripts** (`scripts/`): Utility scripts (wallpaper-theme.sh is legacy; DMS now handles wallpaper selection and triggers matugen natively).

## Conventions

- Nix formatter: `alejandra` (no trailing commas, no semicolons after `in`)
- State version: 25.05 for both hosts
- All flake inputs except hyprland follow `nixpkgs`
- `ryzen-desktop` has a yabridge overlay pinned to a specific nixpkgs commit for Wine compatibility
- Home Manager is integrated as a NixOS module (`home-manager.nixosModules.home-manager`), not used standalone

## Fetching upstream docs

When adding/troubleshooting features in fast-moving tools used here, fetch the docs directly from their source repos via `gh` (installed, no rate limits, no stale cache). Prefer this over `WebFetch` — these repos host their docs as plain Markdown/MDX so a `gh api` call returns clean text rather than rendered HTML.

```bash
# List doc files in a repo
gh api repos/<owner>/<repo>/git/trees/<branch>?recursive=1 --jq '.tree[] | select(.type=="blob") | .path' | grep <topic>

# Read a specific doc
gh api repos/<owner>/<repo>/contents/<path> --jq '.content' | base64 -d

# Code-search across a repo (good for "where is feature X mentioned?")
gh search code --repo <owner>/<repo> "<query>" --limit 30
```

**Repos to consult:**

| Topic | Repo | Branch | Notes |
|---|---|---|---|
| DankMaterialShell (DMS) — IPC commands, settings, compositor integration, plugins | `AvengeMedia/DankLinux-Docs` | `master` | Most useful page: `docs/dankmaterialshell/keybinds-ipc.mdx`. Also covers dankgreeter, danksearch, dgop. |
| Hyprland — config syntax (Lua since 0.55), dispatchers, binds, plugins, NixOS/HM integration | `hyprwm/hyprland-wiki` | `main` | Pages under `content/Configuring/`. Old hyprlang docs live at `wiki.hypr.land/0.54.0/`. |
| Hyprland example config | `hyprwm/Hyprland` | `main` | `example/hyprland.lua` is the canonical reference for current syntax. |
| Home Manager module options (Hyprland, etc.) | `nix-community/home-manager` | `master` | `modules/services/window-managers/hyprland.nix` is authoritative for `wayland.windowManager.hyprland.*` options. |
| Quickshell | `quickshell-mirror/quickshell` | `master` | QML types and IPC. |

Memory may pin a "look here for X" reference (e.g. `dms_docs_reference.md`) — those are starting points, not snapshots. Always re-fetch live before quoting specifics; these projects move fast and cached lists drift.

# NixOS Configuration

## Layout

- `nixos/`
	- `hosts/<name>/` — per-machine system configs (`default.nix`, `hardware.nix`)
	- `modules/` — NixOS modules (boot, networking, users, desktop, etc.)
	- `profiles/` — reusable bundles of system modules (e.g., `common.nix`)
- `home/`
	- `users/panos/` — base HM defaults and per-host overrides under `hosts/`
	- `modules/` — Home Manager modules (shell, git, hyprland, etc.)
	- `profiles/` — reusable HM bundles (e.g., `common.nix`)

The flake wires NixOS hosts via `nixos/hosts/<name>` and Home Manager via `home/users/panos/hosts/<host>.nix`. Shared pieces are grouped in the `profiles/` folders and imported once.

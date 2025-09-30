{ pkgs, inputs, ... }:
{
  # Shared, host-agnostic Home Manager modules for all machines.
  imports = [
    ../modules/stylix.nix
    ../modules/bash.nix
    ../modules/ghostty.nix
    ../modules/git.nix
    ../modules/neovim.nix
    ../modules/ssh.nix
    ../modules/starship.nix
    ../modules/gtk.nix
    ../modules/hyprland.nix
    ../modules/hyprpaper.nix
    ../modules/hypridle.nix
    ../modules/hyprlock.nix
    ../modules/tray.nix
    ../modules/fuzzel.nix
    ../modules/development.nix
  ];

}
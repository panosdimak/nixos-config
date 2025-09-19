{ pkgs, ... }:

{
  programs.kdeconnect.enable = true;
  programs.steam.enable = true;
  # programs.hyprland.enable = true;

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    nixd
    alejandra
    usbutils
    uhubctl
    yabridge
    yabridgectl
    reaper
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    inter
    manrope
  ];
}

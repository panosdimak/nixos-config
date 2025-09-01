{ pkgs, ... }:

{
  programs.kdeconnect.enable = true;
  programs.steam.enable = true;
  # programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    vim
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

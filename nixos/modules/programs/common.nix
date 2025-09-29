{ pkgs, ... }:

{
  # Safe, common tools
  # services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    nixd
    alejandra
    usbutils
    uhubctl
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.martian-mono
    nerd-fonts.space-mono
    nerd-fonts.victor-mono
    inter
  ];
}

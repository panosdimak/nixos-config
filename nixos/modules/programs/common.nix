{ pkgs, ... }:

{
  # Safe, common tools
  # services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    usbutils
    uhubctl
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.martian-mono
    nerd-fonts.space-mono
    nerd-fonts.victor-mono
    nerd-fonts.geist-mono
    inter
  ];
}

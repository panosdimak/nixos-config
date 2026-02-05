{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    usbutils
    uhubctl
  ];

  fonts.packages = with pkgs; [
    # Nerd fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.martian-mono
    nerd-fonts.space-mono
    nerd-fonts.victor-mono
    nerd-fonts.geist-mono

    # UI / fallback fonts
    inter
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    # Serif fonts
    crimson-pro
    ibm-plex
    literata
    lora
    source-serif-pro
  ];
}

{ pkgs, ... }:

{
  # Hyprland comes from nixpkgs rather than upstream's flake: the flake's own
  # release builds aren't reliably on hyprland.cachix.org (v0.56.2 wasn't), and
  # compiling the compositor from source is painful on the laptop.
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    fuzzel
    vicinae
    swaynotificationcenter
    libnotify
    swappy
    networkmanagerapplet
    blueman
    waybar
    hypridle
    hyprlock
    hyprpicker
    hyprsysteminfo
    hyprshot
    brightnessctl
    cliphist
    playerctl
    libsecret
    bibata-cursors
    colloid-icon-theme
    fluent-icon-theme
    kdePackages.breeze-icons
    qt6.qtwayland
    samba
  ];

  services.gvfs = {
    enable = true;
    package = pkgs.gvfs.override { samba = pkgs.samba; };
  };
  services.tumbler.enable = true;

  services.samba-wsdd.enable = true;

  environment.variables.NIXOS_OZONE_WL = "1";
}

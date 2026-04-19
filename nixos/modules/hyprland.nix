{ inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

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
    sunsetr
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

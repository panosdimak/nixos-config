{ lib, pkgs, config, ... }:

let
  cfg = config.profiles.portals;
  defaultsFor = session: (
    if session == "hyprland" then [ "hyprland" "gtk" ]
    else if session == "plasma" then [ "kde" ]
    else if session == "gnome" then [ "gnome" "gtk" ]
    else [ "gtk" ]
  );
in {
  options.profiles.portals = {
    session = lib.mkOption {
      type = lib.types.enum [ "hyprland" "plasma" "gnome" "generic" ];
      default = "generic";
      description = "Session type to prioritize portals for";
    };
    enableGtkFallback = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Include GTK portal as a fallback";
    };
  };

  config = {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals =
        (lib.optionals (cfg.session == "hyprland") [ pkgs.xdg-desktop-portal-hyprland ])
        ++ (lib.optionals (cfg.session == "plasma") [ pkgs.kdePackages.xdg-desktop-portal-kde ])
        ++ (lib.optionals (cfg.session == "gnome") [ pkgs.xdg-desktop-portal-gnome ])
        ++ (lib.optionals cfg.enableGtkFallback [ pkgs.xdg-desktop-portal-gtk ]);
      config = {
        common.default = defaultsFor cfg.session;
        kde.default = [ "kde" ];
      };
    };
  };
}

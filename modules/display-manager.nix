{ lib, config, ... }:

let
  cfg = config.profiles.displayManager;
in {
  options.profiles.displayManager = {
    dm = lib.mkOption {
      type = lib.types.enum [ "gdm" "sddm" "none" ];
      default = "gdm";
      description = "Display manager to use (gdm, sddm, or none).";
    };
    wayland = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Wayland for the chosen display manager when supported.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.dm == "gdm") {
      services.displayManager.gdm = {
        enable = true;
        wayland = cfg.wayland;
      };
    })

    (lib.mkIf (cfg.dm == "sddm") {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = cfg.wayland;
      };
    })

    (lib.mkIf (cfg.dm == "none") {
      services.displayManager = {
        # Force-disable common DMs in case other modules set them
        gdm.enable = lib.mkForce false;
        sddm.enable = lib.mkForce false;
      };
    })
  ];
}

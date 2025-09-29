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
    enableGnomeKeyringPam = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable PAM integration to unlock GNOME Keyring at login for the chosen display manager (or login when none).";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.dm == "gdm") {
      services.displayManager.gdm = {
        enable = true;
        wayland = cfg.wayland;
      };
      # Unlock gnome-keyring at login for GDM if enabled
      security.pam.services = lib.mkIf cfg.enableGnomeKeyringPam {
        gdm.enableGnomeKeyring = true;
      };
    })

    (lib.mkIf (cfg.dm == "sddm") {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = cfg.wayland;
      };
      # Unlock gnome-keyring at login for SDDM if enabled
      security.pam.services = lib.mkIf cfg.enableGnomeKeyringPam {
        sddm.enableGnomeKeyring = true;
      };
    })

    (lib.mkIf (cfg.dm == "none") {
      services.displayManager = {
        # Force-disable common DMs in case other modules set them
        gdm.enable = lib.mkForce false;
        sddm.enable = lib.mkForce false;
      };
      # Fallback: unlock gnome-keyring at TTY login when no DM
      security.pam.services = lib.mkIf cfg.enableGnomeKeyringPam {
        login.enableGnomeKeyring = true;
      };
    })
  ];
}

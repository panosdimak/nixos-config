{ lib, ... }:
{ 
  programs = {
    # Required so Stylix can inject its theme into fuzzel's config
    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = lib.mkForce "SFMono Nerd Font:size=14.5";
          dpi-aware = "yes";
        };
        border = {
          selection-radius = 10;
        };
      };
    };
  };
}
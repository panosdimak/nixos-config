{pkgs, ...}: {
  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults env_keep += "EDITOR VISUAL"
    '';
  };

  security.polkit.enable = true;

  # polkit-gnome agent is launched from Hyprland's autostart list in
  # home/modules/hyprland/default.nix rather than as a systemd user-service, so it
  # runs inside the real graphical session only and never in a greeter context.
  # environment.systemPackages = [pkgs.polkit_gnome];
}

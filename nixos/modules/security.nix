{pkgs, ...}: {
  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults env_keep += "EDITOR VISUAL"
    '';
  };

  security.polkit.enable = true;

  # polkit-gnome agent is launched by Hyprland's exec-once in
  # home/modules/hyprland.nix. A systemd user-service would also fire in
  # the gdm-greeter's systemd-user instance and (via Wants=graphical-session.target)
  # pre-activate graphical-session.target, which makes gnome-session-50.0
  # abort with "A graphical session is already running!" and the GDM greeter
  # never draws.
  environment.systemPackages = [pkgs.polkit_gnome];
}

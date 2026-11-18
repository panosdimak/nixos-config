{
  lib,
  pkgs,
  ...
}: let
  # Terminal paste can't carry images, so a Claude Code session on the desktop
  # never sees a screenshot taken here. Upload the clipboard image to the
  # desktop and swap the clipboard for its path, which pastes as text.
  clipToDesktop = pkgs.writeShellApplication {
    name = "clip-to-desktop";
    runtimeInputs = with pkgs; [coreutils gnugrep libnotify openssh wl-clipboard];
    text = ''
      export SSH_AUTH_SOCK="''${SSH_AUTH_SOCK:-$XDG_RUNTIME_DIR/gcr/ssh}"

      if ! wl-paste --list-types | grep -qx image/png; then
        notify-send -a "Clip to desktop" "No image on the clipboard"
        exit 1
      fi

      f="/tmp/clip-$(date +%Y%m%d-%H%M%S).png"
      if wl-paste -t image/png | ssh -o BatchMode=yes -o ConnectTimeout=5 desktop "cat > $f"; then
        printf '%s' "$f" | wl-copy
        notify-send -a "Clip to desktop" "Uploaded, path copied" "$f"
      else
        notify-send -a "Clip to desktop" -u critical "Upload failed"
        exit 1
      fi
    '';
  };
in {
  imports = [
    ./common.nix
    ./default.nix
  ];

  home.packages = [clipToDesktop];

  wayland.windowManager.hyprland.extraConfig = lib.mkAfter ''
    hl.bind("SUPER + SHIFT + U", hl.dsp.exec_cmd("clip-to-desktop"))
  '';

  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        output = "eDP-1";
        mode = "1920x1080@60";
        position = "0x0";
        scale = 1.2;
      }
    ];

    env = [
      {_args = ["ELECTRON_OZONE_PLATFORM_HINT" "auto"];}
    ];

    device = [
      {
        name = "ven_04f3:00-04f3:3259-touchpad";
        sensitivity = 0.1;
      }
    ];
  };
}

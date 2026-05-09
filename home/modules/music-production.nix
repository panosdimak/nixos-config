{ pkgs, ...}:

let
  # REAPER's SWELL has a race in X11 selection handling under XWayland:
  # on Ctrl+C of a recorded media item, it feeds GDK a GdkWindow that's
  # already being destroyed, the follow-up ChangeProperty hits a dead X
  # window, and the async error kills the process. GDK_SYNCHRONIZE=1
  # shifts timing so GDK's client-side GDK_IS_WINDOW assertion catches
  # the dead pointer and returns early (two Gdk-CRITICAL warnings, but
  # copy/paste still works). GDK_BACKEND=x11 narrows the original
  # crash scope further. Both together: stable.
  reaper-x11 = pkgs.symlinkJoin {
    name = "reaper-x11";
    paths = [ pkgs.reaper ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/reaper \
        --set GDK_BACKEND x11 \
        --set GDK_SYNCHRONIZE 1
    '';
  };
in
{
  home.packages = with pkgs; [
    wineWow64Packages.staging winetricks mangohud protontricks
    yabridge
    yabridgectl
    reaper-x11
    bitwig-studio
  ];

  # yabridge bundles Wine 9.21 which stack-overflows on some Neural DSP
  # plugins (Plini, Granophyre, Fortin). System Wine 11.x handles them fine.
  home.sessionVariables.WINELOADER = "${pkgs.wineWow64Packages.staging}/bin/wine";

  # The chainloader stubs that yabridgectl drops into each .vst3 bundle look
  # up the real libyabridge-*.so by walking $NIX_PROFILES. systemd-app scopes
  # don't carry NIX_PROFILES, so Bitwig's sandboxed plugin hosts fail the
  # lookup. ~/.local/share/yabridge is also searched by default and doesn't
  # depend on env, so anchor the libs there.
  home.file = {
    ".local/share/yabridge/libyabridge-vst2.so".source = "${pkgs.yabridge}/lib/libyabridge-vst2.so";
    ".local/share/yabridge/libyabridge-vst3.so".source = "${pkgs.yabridge}/lib/libyabridge-vst3.so";
    ".local/share/yabridge/libyabridge-clap.so".source = "${pkgs.yabridge}/lib/libyabridge-clap.so";
  };
}

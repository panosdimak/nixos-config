{ pkgs, ...}:

let
  # REAPER's SWELL hits BadWindow crashes under XWayland when copying
  # tracks with recordings; forcing the GDK x11 backend avoids the crash.
  reaper-x11 = pkgs.symlinkJoin {
    name = "reaper-x11";
    paths = [ pkgs.reaper ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/reaper --set GDK_BACKEND x11
    '';
  };
in
{
  home.packages = with pkgs; [
    wineWow64Packages.staging winetricks mangohud protontricks
    yabridge
    yabridgectl
    reaper-x11
  ];
}
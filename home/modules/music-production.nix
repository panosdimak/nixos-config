{ pkgs, ...}:

{
  home.packages = with pkgs; [
    wineWow64Packages.staging winetricks mangohud protontricks
    yabridge
    yabridgectl
    reaper
  ];
}
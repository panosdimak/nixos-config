{ pkgs, ... }:

{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    yabridge
    yabridgectl
    reaper
  ];
}
{ ... }:
{
  imports = [ 
    ../common.nix
    # ../modules/plasma.nix
    ../modules/music-production.nix
    ../modules/bash.nix
    ../modules/ghostty.nix
    ../modules/git.nix
    ../modules/neovim.nix
    ../modules/ssh.nix
    ../modules/starship.nix
    ../modules/gtk.nix
    ../modules/spicetify.nix
    ../modules/stylix.nix
  ];

  profiles.gtk.iconThemeName = "Colloid-Pink-Gruvbox-Light";
}
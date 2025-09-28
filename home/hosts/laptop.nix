{ ... }:

{
  imports = [ 
    ../common.nix
    ../modules/bash.nix
    ../modules/ghostty.nix
    ../modules/git.nix
    ../modules/neovim.nix
    ../modules/ssh.nix
    ../modules/starship.nix
    ../modules/gtk.nix
    ../modules/stylix.nix
  ];

  profiles.gtk.iconThemeName = "Colloid-Teal-Gruvbox-Light";
}

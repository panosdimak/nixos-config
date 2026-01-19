{
  description = "My NixOS configuration";

  inputs = {
    # Base Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Musnix
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zen browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # San Francisco Fonts | Apple Fonts
    apple-fonts = {
      url= "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spicetify-Nix
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprtasking = {
      url = "github:raybbian/hyprtasking";
      inputs.hyprland.follows = "hyprland";
    };

    # Hyprland plugins
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
  };
  
  outputs = { self, nixpkgs, home-manager, musnix, stylix, zen-browser, apple-fonts, ... }@inputs: {
    nixosConfigurations = {
      ryzen-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/ryzen-desktop

          # Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            # home-manager.sharedModules = [ inputs.plasma-manager.homeModules."plasma-manager" ];
            # Use per-host Home Manager module composition
            home-manager.users.panos = import ./home/users/panos/hosts/ryzen-desktop.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          
          # Stylix module
          stylix.nixosModules.stylix

          # Musnix module
          musnix.nixosModules.musnix
        ];
      };

      inspiron-15 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/inspiron-15

          {
            nixpkgs.overlays = [
              (final: prev: {
                gtksourceview5 = prev.gtksourceview5.overrideAttrs (_: {
                  checkPhase = ":";
                });
              })
            ];
          }

          # Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.users.panos = import ./home/users/panos/hosts/inspiron-15.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }

          # Stylix module
          stylix.nixosModules.stylix
        ];
      };
    };
  };
}

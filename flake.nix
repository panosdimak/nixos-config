{
  description = "My NixOS configuration";

  inputs = {
    # Base Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager, following nixpkgs
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Plasma Manager
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    # Stylix
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Musnix
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs";

    # Zen browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
  };

  outputs = { self, nixpkgs, home-manager, musnix, stylix, zen-browser, ... }@inputs: {
    nixosConfigurations = {
      ryzen-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/ryzen-desktop.nix

          # Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              inputs.plasma-manager.homeModules."plasma-manager"
            ];
            home-manager.users.panos = import ./home/panos.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          
          # Stylix module
          stylix.nixosModules.stylix

          # Musnix module
          musnix.nixosModules.musnix
        ];
      };
    };
  };
}

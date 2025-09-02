{
  description = "My NixOS configuration";

  inputs = {
    # Base Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager, following nixpkgs
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Musnix
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs";

    # Zen browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, musnix, zen-browser, ... }@inputs: {
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
            home-manager.users.panos = import ./home/panos.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }

          # Musnix module
          musnix.nixosModules.musnix
        ];
      };
    };
  };
}
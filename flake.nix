{
  description = "My NixOS configuration";

  inputs = {
    # Base Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager, following nixpkgs
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Extra flakes
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }@inputs: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop.nix

          # Optional: enable Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.potis = import ./home/potis.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
    
    # Standalone Home Manager configs
    homeConfigurations.potis = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      modules = [ 
        ./home/potis.nix
      ];
      extraSpecialArgs = { inherit inputs; };
    };

  };
}

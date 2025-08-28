{
  description = "My NixOS configuration";

  inputs = {
    # Nixpkgs (stable)
    nixpkgs.url = "github:NixOS/nixpkgs/25.05";

    # Home Manager, following the same nixpkgs
    # home-manager.url = "github:nix-community/home-manager/release-25.05";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";

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
          # home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   home-manager.users. = import ./home/potis.nix;
          # }
          {
              environment.systemPackages = [
                zen-browser.packages.x86_64-linux.twilight
              ];
          }
        ];
      };
    };
  };
}

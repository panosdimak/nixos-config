{
  description = "Python dev env";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [
        (pkgs.python312.withPackages (ps: with ps; [ 
          numpy
          matplotlib
        ]))
      ];

      shellHook = ''
          echo "🐍 Welcome to Python devshell"
      '';

    };
  };
}

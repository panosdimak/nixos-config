{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
 
  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        cmake
        mesa
        glfw
        glew
        glm
        assimp
        pkg-config
        xorg.libX11
        xorg.libXrandr
        xorg.libXinerama
        xorg.libXcursor
        xorg.libXi 
        xorg.libXxf86vm
        freetype
      ];
    };
  };
}

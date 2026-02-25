{
  description = "RXDL Custom Packages";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # This defines the packages output
      packages.${system} = {
        cherry-studio = pkgs.callPackage ./cherry-studio.nix { };
        # When you add a new package, just add a line here:
        # my-other-app = pkgs.callPackage ./my-other-app.nix { };
      };

      overlays.default = final: prev: {
        cherry-studio = prev.callPackage ./cherry-studio.nix { };
      };
    };
}

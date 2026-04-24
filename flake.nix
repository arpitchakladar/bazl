{
  description = "bare metal i686 project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs =
    {
      nixpkgs,
      devenv,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          (
            { pkgs, ... }:
            {
              packages = with pkgs; [
                cmake
                nasm
                ninja
                qemu
                xxd
                pkgsCross.i686-embedded.buildPackages.gcc
                pkgsCross.i686-embedded.buildPackages.binutils
              ];

              enterShell = ''
                export PATH=$PATH:${pkgs.pkgsCross.i686-embedded.buildPackages.gcc}/bin
              '';
            }
          )
        ];
      };
    };
}

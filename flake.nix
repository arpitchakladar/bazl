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
                clang-tools  # provides clangd
                asm-lsp
              ];

              git-hooks.hooks = {
                clang-format = {
                  enable = true;
                  name = "clang-format";
                  entry = "${pkgs.clang-tools}/bin/clang-format -i --style=file";
                  files = "\\.(c|cpp|h|hpp)$";
                  pass_filenames = true;
                };
                clang-tidy = {
                  enable = true;
                  name = "clang-tidy";
                  entry = "${pkgs.clang-tools}/bin/clang-tidy -p build";
                  files = "\\.(c|cpp)$";
                  pass_filenames = true;
                };
              };

              env = {
                CMAKE_EXPORT_COMPILE_COMMANDS = "1";
              };

              enterShell = ''
                export PATH=$PATH:${pkgs.pkgsCross.i686-embedded.buildPackages.gcc}/bin
              '';
            }
          )
        ];
      };
    };
}

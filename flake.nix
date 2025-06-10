{
	description = "OS-dev shell with CMake, NASM and i686-elf tool-chain";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
				};
			in {
				devShells.default = pkgs.mkShell {
					packages = with pkgs; [
						cmake
						nasm
						ninja
						qemu
						xxd
						pkgsCross.i686-embedded.buildPackages.gcc
						pkgsCross.i686-embedded.buildPackages.binutils
					];

					# Optional conveniences
					shellHook = ''
						export TARGET=i686-elf
						export CC=${pkgs.pkgsCross.i686-embedded.buildPackages.gcc}/bin/i686-elf-gcc
						export LD=${pkgs.pkgsCross.i686-embedded.buildPackages.gcc}/bin/i686-elf-ld
						export PATH=$PATH:${pkgs.pkgsCross.i686-embedded.buildPackages.gcc}/bin
						echo ${pkgs.pkgsCross.i686-embedded.buildPackages.gcc}
					'';
				};
			});
}

{
	description = "Dev environment with cmake, nasm, i386-elf-gcc, and binutils";

	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

	outputs = { self, nixpkgs }: {
		devShells.default = let
			system = "x86_64-linux";
			pkgs = import nixpkgs { inherit system; };
		in
			pkgs.mkShell {
				buildInputs = [
					pkgs.cmake
					pkgs.nasm
					pkgs.pkgsCross.gnu32.buildPackages.gcc
					pkgs.pkgsCross.gnu32.buildPackages.binutils
				];

				shellHook = ''
					echo "Development environment ready."
					echo "CMake version: $(cmake --version | head -n1)"
					echo "NASM version: $(nasm -v)"
					echo "i386-elf-gcc version: $(${CROSS_GCC:-i686-unknown-linux-gnu-gcc} --version | head -n1)"
				'';
			};
	};
}


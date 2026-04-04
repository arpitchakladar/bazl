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

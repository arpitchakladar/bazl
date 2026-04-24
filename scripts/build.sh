#!/bin/sh
PARAMS="-B build"
LINKER="$(whereis -b i686-elf-ld | awk 'NF>1{print $NF}')"
COMPILER="$(whereis -b i686-elf-gcc | awk 'NF>1{print $NF}')"
if [ ! -z $LINKER ] && [ ! -z $COMPILER ]
then
	PARAMS="$PARAMS -DLINKER=$LINKER -DC_COMPILER=$COMPILER"
fi
CMAKE_EXPORT_COMPILE_COMMANDS=1 cmake $PARAMS $@
cp build/compile_commands.json compile_commands.json

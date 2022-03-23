#!/bin/sh
PARAMS="-B build"
LINKER="$(whereis -b i386-elf-ld | awk 'NF>1{print $NF}')"
COMPILER="$(whereis -b i386-elf-gcc | awk 'NF>1{print $NF}')"
if [ ! -z $LINKER ] && [ ! -z $COMPILER ]
then
	PARAMS="$PARAMS -DLINKER=$LINKER -DC_COMPILER=$COMPILER"
fi
cmake $PARAMS $@

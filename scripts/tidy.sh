#!/bin/sh
find ./kernel ./boot-loader -type f \( -name "*.c" -o -name "*.h" \) -exec clang-tidy -fix --fix-errors --fix-notes {} +
./scripts/format.sh

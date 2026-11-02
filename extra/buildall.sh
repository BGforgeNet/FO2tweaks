#!/bin/bash
# shellcheck source=./env.sh

set -xeu -o pipefail

# Source environment
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./env.sh
. "$script_dir/env.sh" >/dev/null 2>&1

mkdir -p "$SCRIPTS_DIR"

# Compile the scripts with tssl. It also writes each script's .ssl, which sslc compiles as a cross-check:
# the two compilers must produce identical bytecode.
SCRIPTS_DIR_ABS="$(realpath "$SCRIPTS_DIR")"
pnpm exec tssl source -r --opt 2 -s --ssl -q
check_dir="$(mktemp -d)"
cd source
for f in *.tssl; do
    name="${f%.tssl}"
    "$COMPILE" -l -O2 -p -s -q -n "$name.ssl" -o "$check_dir/$name.int"
    if ! cmp -s "$name.int" "$check_dir/$name.int"; then
        echo "tssl and sslc produced different bytecode for $name" >&2
        exit 1
    fi
    mv "$name.int" "$SCRIPTS_DIR_ABS/"
done
rm -r "$check_dir"

#!/bin/bash
# shellcheck source=./env.sh

set -xeu -o pipefail

# Get script directory
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir/.."

# Source environment
. extra/env.sh

# Download tools
./extra/prepare.sh

# Build all scripts
./extra/buildall.sh

# Package the mod
./extra/package.sh
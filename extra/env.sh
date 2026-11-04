#!/bin/bash

set -xeu -o pipefail

# Tool versions and URLs
export SFALL_VERSION="4.5.1"
SSLC_VERSION="2026-09-17-13-26-18"
export SSLC_URL="https://github.com/sfall-team/sslc/releases/download/${SSLC_VERSION}/sslc-linux"
DAT3_VERSION="v0.11.3"
export DAT3_URL="https://github.com/BGforgeNet/dat3/releases/download/${DAT3_VERSION}/dat3"

# Directories
EXTRA_DIR="$(realpath extra)"
export EXTRA_DIR
export BIN_DIR="$EXTRA_DIR/bin"
export MODS_DIR="mods"
export DATA_DIR="data"
export SCRIPTS_DIR="$DATA_DIR/scripts"

# Build tools
export COMPILE="$BIN_DIR/sslc"
export DAT3="$BIN_DIR/dat3"

# Mod info
export MOD_NAME="fo2tweaks"

# Set fixed timestamp for files/directories, for reproducible archives.
# Usage: fix-timestamp <file_or_dir> [<file_or_dir> ...]
function fix-timestamp() {
    # Use 2000-01-01 00:00:00 UTC for reproducible timestamps
    local timestamp="200001010000"
    for target in "$@"; do
        if [[ -d "$target" ]]; then
            # Directory: touch recursively
            TZ=UTC find "$target" -exec touch -t "$timestamp" {} +
        elif [[ -e "$target" ]]; then
            # File: touch directly
            TZ=UTC touch -t "$timestamp" "$target"
        else
            echo "Error: '$target' does not exist"
            return 1
        fi
    done
}
export -f fix-timestamp

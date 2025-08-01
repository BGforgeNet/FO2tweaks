#!/bin/bash

set -xeu -o pipefail

# Directories
EXTRA_DIR="$(realpath extra)"
export EXTRA_DIR
export BIN_DIR="$EXTRA_DIR/bin"
export MODS_DIR="mods"
export DATA_DIR="data"
export SCRIPTS_DIR="$DATA_DIR/scripts"
export HEADERS_DIR="source/headers"

# Build tools
export COMPILE="$BIN_DIR/sslc"
export DAT3="$BIN_DIR/dat3"

# Mod info
export MOD_NAME="fo2tweaks"


# Tool versions and URLs
export SFALL_VERSION="4.4.7"
SSLC_VERSION="2025-06-18-01-40-04"
export SSLC_URL="https://github.com/sfall-team/sslc/releases/download/${SSLC_VERSION}/sslc-linux"
DAT3_VERSION="v0.2.0"
export DAT3_URL="https://github.com/BGforgeNet/dat3/releases/download/${DAT3_VERSION}/dat3"

# Repository URLs
export RPU_VERSION="v2.3.33"
export RPU_REPO_URL="https://github.com/BGforgeNet/Fallout2_Restoration_Project.git"
export RPU_HEADERS_PATH="scripts_src/headers"
export PARTY_ORDERS_VERSION="v1.16"
export PARTY_ORDERS_REPO_URL="https://github.com/BGforgeNet/Fallout2_Party_Orders.git"
export PARTY_ORDERS_HEADERS_PATH="source/headers/party_orders"
export SFALL_REPO_URL="https://github.com/sfall-team/sfall.git"
export SFALL_HEADERS_PATH="artifacts/scripting/headers"

# git magic to clone a subdirectory, for faster build
function git-clone-dir() {
    url="$1"
    dir="$2"
    subdir="$3"
    tag="${4:-}"  # optional tag/branch

    if [[ -n "$tag" ]]; then
        git clone -n --depth=1 --filter=tree:0 --branch "$tag" "$url" "$dir"
    else
        git clone -n --depth=1 --filter=tree:0 "$url" "$dir"
    fi
    pushd .
    cd "$dir"
    git sparse-checkout set --no-cone "$subdir"
    git checkout
    popd
}
export -f git-clone-dir

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

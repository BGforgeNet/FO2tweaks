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

# Wine settings
export WINEARCH=win32
export WINEDEBUG=-all

# Tool versions and URLs
export SFALL_VERSION="4.4.7"
export SSLC_URL="https://github.com/sfall-team/sslc/releases/download/2025-06-18-01-40-04/sslc-linux"
export DAT3_URL="https://github.com/BGforgeNet/dat3/releases/download/v0.2.0/dat3"

# Repository URLs
export RP_REPO_URL="https://github.com/BGforgeNet/Fallout2_Restoration_Project.git"
export RP_HEADERS_PATH="scripts_src/headers"
export PARTY_ORDERS_REPO_URL="https://github.com/BGforgeNet/Fallout2_Party_Orders.git"
export PARTY_ORDERS_HEADERS_PATH="source/headers/party_orders"
export SFALL_REPO_URL="https://github.com/sfall-team/sfall.git"
export SFALL_HEADERS_PATH="artifacts/scripting/headers"

# git magic to clone a subdirectory, for faster build
function git-clone-dir() {
    url="$1"
    dir="$2"
    subdir="$3"

    git clone -n --depth=1 --filter=tree:0 "$url" "$dir"
    pushd .
    cd "$dir"
    git sparse-checkout set --no-cone "$subdir"
    git checkout
    popd
}
export -f git-clone-dir

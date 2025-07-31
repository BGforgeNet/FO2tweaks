#!/bin/bash
# shellcheck source=./env.sh

set -xeu -o pipefail

# Source environment
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./env.sh
. "$script_dir/env.sh" >/dev/null 2>&1

# Ensure bin directory exists
mkdir -p "$BIN_DIR"

# Download sslc compiler if it doesn't exist
if [[ ! -f "$COMPILE" ]]; then
    # shellcheck disable=2154
    wget -q "$SSLC_URL" -O "$COMPILE"
    chmod +x "$COMPILE"
fi

# Download dat3 tool if it doesn't exist
if [[ ! -f "$DAT3" ]]; then
    # shellcheck disable=2154
    wget -q "$DAT3_URL" -O "$DAT3"
    chmod +x "$DAT3"
fi

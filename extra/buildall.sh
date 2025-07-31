#!/bin/bash
# shellcheck source=./env.sh

set -xeu -o pipefail

# Source environment
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./env.sh
. "$script_dir/env.sh" >/dev/null 2>&1

mkdir -p "$SCRIPTS_DIR"

# Clone/update headers directly into source/headers
cd "$HEADERS_DIR"

# RP headers
if [[ -d rp/.git ]]; then
    cd rp
    git pull
    cd ..
else
    # Clean up any existing symlink or non-git directory
    rm -rf rp
    git-clone-dir "$RP_REPO_URL" rp "$RP_HEADERS_PATH"
    # Move headers to correct location
    mv "rp/$RP_HEADERS_PATH"/* rp/
    rm -rf rp/scripts_src
fi

# Party Orders headers
if [[ -d party_orders/.git ]]; then
    cd party_orders
    git pull
    cd ..
else
    # Clean up any existing symlink or non-git directory
    rm -rf party_orders
    git-clone-dir "$PARTY_ORDERS_REPO_URL" party_orders "$PARTY_ORDERS_HEADERS_PATH"
    # Move headers to correct location
    mv "party_orders/$PARTY_ORDERS_HEADERS_PATH"/* party_orders/
    rm -rf party_orders/source
fi

# Sfall headers
if [[ -d sfall/.git ]]; then
    cd sfall
    git pull
    cd ..
else
    # Clean up any existing symlink or non-git directory
    rm -rf sfall
    git-clone-dir "$SFALL_REPO_URL" sfall "$SFALL_HEADERS_PATH"
    # Move headers to correct location
    mv "sfall/$SFALL_HEADERS_PATH"/* sfall/
    rm -rf sfall/artifacts
fi

cd ../..

# Compile SSL scripts
SCRIPTS_DIR_ABS="$(realpath "$SCRIPTS_DIR")"
cd source
for f in $(ls | grep "\.ssl$"); do
    int_name="$(echo "$f" | sed 's|\.ssl$|.int|')"
    "$COMPILE" -l -O2 -p -s -q -n "$f" -o "$SCRIPTS_DIR_ABS/$int_name"
done

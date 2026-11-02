#!/bin/bash
# shellcheck source=./env.sh

set -xeu -o pipefail

# Source environment
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./env.sh
. "$script_dir/env.sh" >/dev/null 2>&1

mkdir -p "$SCRIPTS_DIR"

# Function to handle header repository cloning/updating
update_headers() {
    local external_dir="$1"
    local target_dir="$2"
    local repo_url="$3"
    local headers_path="$4"
    local version="$5"

    if [[ -d "external/$external_dir/.git" ]]; then
        cd "external/$external_dir"
        git fetch origin "$version"
        git checkout FETCH_HEAD
        cd ../..
    else
        # Clean up any existing directory
        rm -rf "external/$external_dir"
        mkdir -p external
        git-clone-dir "$repo_url" "external/$external_dir" "$headers_path"
        cd "external/$external_dir"
        git fetch origin "$version"
        git checkout FETCH_HEAD
        cd ../..
    fi
    # Always sync the headers directory after ensuring correct version
    rsync -a "external/$external_dir/$headers_path"/ "$HEADERS_DIR/$target_dir"/
}

# Update all header repositories
update_headers rpu rp "$RPU_REPO_URL" "$RPU_HEADERS_PATH" "$RPU_VERSION"
update_headers party_orders party_orders "$PARTY_ORDERS_REPO_URL" "$PARTY_ORDERS_HEADERS_PATH" "$PARTY_ORDERS_VERSION"
update_headers sfall sfall "$SFALL_REPO_URL" "$SFALL_HEADERS_PATH" "$SFALL_GIT_VERSION"

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

#!/bin/bash

set -xeu -o pipefail

# git magic to clone a subdirectory, for faster build
function git-clone-dir() {
    url="$1"
    dir="$2"
    subdir="$3"

    git clone -n --depth=1 --filter=tree:0 "$url" "$dir"
    cd "$dir"
    git sparse-checkout set --no-cone "$subdir"
    git checkout
}

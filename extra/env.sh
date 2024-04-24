#!/bin/bash

set -xeu -o pipefail

extra_dir="$(realpath extra)"
export extra_dir
export bin_dir="$extra_dir/bin"
export mods_dir="mods"
export mpack_version=${mpack_version:-4.3}
export mpack_7z="mpack.7z"
export sfall_version=${sfall_version:-4.3}
export WINEARCH=win32
export WINEDEBUG=-all
export mod_name=fo2tweaks

set +xeu +o pipefail

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

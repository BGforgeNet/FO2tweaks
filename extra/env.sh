#!/bin/bash

set -xeu -o pipefail

export extra_dir="$(realpath extra)"
export bin_dir="$extra_dir/bin"
export mods_dir="$(pwd)/mods"
export mpack_version=${mpack_version:-4.3}
export mpack_7z="mpack.7z"
export sfall_version=${sfall_version:-4.3}
export WINEARCH=win32
export WINEDEBUG=-all
export mod_name=fo2tweaks

set +xeu +o pipefail

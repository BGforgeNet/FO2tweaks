#!/bin/bash

set -xeu -o pipefail

extra_dir=${extra_dir:-extra}
mpack_version=${mpack_version:-4.3}

mpack_file="modderspack_$mpack_version.7z"
mpack_url="https://sourceforge.net/projects/sfall/files/Modders%20pack/$mpack_file/download"
compile_exe="compile.exe"
mpack_compile="ScriptEditor/resources/$compile_exe"

# directories
cache_dir="$HOME/.cache/build"
bin_dir="$(realpath extra/bin)"
mkdir -p "$cache_dir" "$bin_dir"

# compile.exe, check cache
wget -q "$mpack_url" -O mpack.7z
7zr e mpack.7z "$mpack_compile"
mv -f "$compile_exe" "$cache_dir/"
# copy
cp -f "$cache_dir/$compile_exe" "$bin_dir/"

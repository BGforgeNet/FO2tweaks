#!/bin/bash

set -xeu -o pipefail

# shellcheck disable=2154  # from env.sh
dat3=$bin_dir/dat3

short_sha="$(git rev-parse --short HEAD)"
# defaults, local build or github non-tagged
export version="git$short_sha"

# tagged build
if [[ -n "${GITHUB_REF-}" ]]; then               # github build
  if echo "$GITHUB_REF" | grep "refs/tags"; then # tagged
    version="$(echo "$GITHUB_REF" | sed 's|refs\/tags\/||')"
    export version
  fi
fi

# data
# shellcheck disable=2154  # from env.sh
dat="$mod_name.dat"
# shellcheck disable=2154  # from env.sh
mkdir -p "$mods_dir"

cd data
rm -rf text/po # gettext translations
$dat3 a "$dat" ./*
cd ..
mv "data/$dat" "$mods_dir/"

# sfall
# shellcheck disable=2154  # from build.yml
sfall_url="https://sourceforge.net/projects/sfall/files/sfall/sfall_${sfall_version}.7z/download"
wget -q "$sfall_url" -O sfall.7z
7zr e sfall.7z ddraw.dll
zip -r "${mod_name}_${version}.zip" ddraw.dll "$mods_dir/" # our package

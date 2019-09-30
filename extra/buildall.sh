#!/bin/bash

set -xeu -o pipefail

extra_dir="${extra_dir:-extra}"
extra_dir="$(realpath $extra_dir)"
bin_dir="$extra_dir/bin"
compile="$bin_dir/compile.exe"
dst="data/scripts"
mkdir -p "$dst"
dst="$(realpath $dst)"
headers_dir="../source/headers"

if ! $extra_dir/need-build.sh ; then
  echo "scripts haven't changed, skipping build"
  exit 0
fi

mkdir -p external
cd external
if [[ -d rp ]]; then
  cd rp
  git pull
  cd ..
else
  git clone https://github.com/BGforgeNet/Fallout2_Restoration_Project.git rp
fi
ln -sf rp/scripts_src/HEADERS "$headers_dir/headers"

if [[ -d party_orders ]]; then
  cd party_orders
  git pull
  cd ..
else
  git clone https://github.com/BGforgeNet/fallout2-party-orders.git party_orders
fi
ln -sf party_orders/source/headers/party_orders "$headers_dir/party_orders"

if [[ -d sfall ]]; then
  cd sfall
  git pull
  cd ..
else
  git clone https://github.com/phobos2077/sfall.git sfall
fi
ln -sf sfall/artifacts/scripting/headers "$headers_dir/sfall"

cd ..

files=$(cat $extra_dir/build.list)
mkdir -p $dst
cd source
for f in $files; do
  int_name="$(echo $f | tr "[A-Z]" "[a-z]" | sed 's|\.ssl$|.int|')"
  wine $compile -l -O2 -p -s -q -n "$f" -o "$dst/$int_name"
done

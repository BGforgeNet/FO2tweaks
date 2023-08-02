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
external_dir="../../external"
source ./git.sh

mkdir -p external
cd external
if [[ -d rp ]]; then
  cd rp
  git pull
  cd ..
else
  git-clone-dir https://github.com/BGforgeNet/Fallout2_Restoration_Project.git rp scripts_src/headers
fi
rm -f "$headers_dir/rp"
ln -sf "$external_dir/rp/scripts_src/headers" "$headers_dir/rp"

if [[ -d party_orders ]]; then
  cd party_orders
  git pull
  cd ..
else
  git-clone-dir https://github.com/BGforgeNet/Fallout2_Party_Orders.git party_orders source/headers
fi
rm -f  "$headers_dir/party_orders"
ln -sf "$external_dir/party_orders/source/headers/party_orders" "$headers_dir/party_orders"

if [[ -d sfall ]]; then
  cd sfall
  git pull
  cd ..
else
  git-clone-dir https://github.com/phobos2077/sfall.git sfall artifacts/scripting/headers
fi
rm -f  "$headers_dir/sfall"
ln -sf "$external_dir/sfall/artifacts/scripting/headers" "$headers_dir/sfall"

cd ..

mkdir -p $dst
cd source
for f in $(ls | grep "\.ssl$"); do
  int_name="$(echo $f | sed 's|\.ssl$|.int|')"
  wine $compile -l -O2 -p -s -q -n "$f" -o "$dst/$int_name"
done

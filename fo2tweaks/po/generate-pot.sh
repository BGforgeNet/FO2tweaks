#!/bin/bash

set -xeu -o pipefail

base_dir='fo2tweaks'
tra_dir="$base_dir/tra"
po_dir="$base_dir/po"
tmp="$po_dir/tmp.pot"
pot="$po_dir/english.pot"

eng_dir="$tra_dir/english"
for file in $(ls $eng_dir); do
  echo $file
  tra2po "$eng_dir/$file" $tmp
  if [[ -f $pot ]]; then
    msgcat --no-wrap $tmp $pot -o $pot
  else
    mv $tmp $pot
  fi
  rm -f $tmp
done

for lang in $(ls $tra_dir | grep -v 'english'); do
  echo $lang
  cp $pot "$po_dir/$lang.po"
done

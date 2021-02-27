#!/bin/bash

set -xeu -o pipefail

pushd extra/nsis

  makensis -V4 installer.nsi

popd
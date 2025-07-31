#!/bin/bash

set -xeu -o pipefail

# from env.sh
# shellcheck disable=2154
wget -q "$sslc_url" -O "$compile"
# shellcheck disable=2154
wget -q "$dat3_url" -O "$dat3"
chmod +x "$compile" "$dat3"

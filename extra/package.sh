#!/bin/bash
# shellcheck source=./env.sh

set -xeu -o pipefail

# Source environment
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./env.sh
. "$script_dir/env.sh" >/dev/null 2>&1

# Check for required dependencies
if ! command -v 7z &>/dev/null; then
    echo "Error: p7zip is required but not installed. Please install it:"
    echo "  Ubuntu/Debian: sudo apt-get install p7zip"
    echo "  macOS: brew install p7zip"
    exit 1
fi

short_sha="$(git rev-parse --short HEAD)"
# defaults, local build or github non-tagged
export VERSION="git$short_sha"

# tagged build
if [[ -n "${GITHUB_REF-}" ]]; then                 # github build
    if echo "$GITHUB_REF" | grep "refs/tags"; then # tagged
        VERSION="$(echo "$GITHUB_REF" | sed 's|refs\/tags\/||')"
        export VERSION
    fi
fi

# Create dat file
DAT_FILE="$MOD_NAME.dat"
mkdir -p "$MODS_DIR"

cd "$DATA_DIR"
rm -rf text/po # gettext translations
"$DAT3" a "$DAT_FILE" scripts text
cd ..
mv "$DATA_DIR/$DAT_FILE" "$MODS_DIR/"

# Download and extract sfall
SFALL_ARCHIVE="sfall_${SFALL_VERSION}.7z"
SFALL_URL="https://sourceforge.net/projects/sfall/files/sfall/${SFALL_ARCHIVE}/download"
if [[ ! -f "$SFALL_ARCHIVE" ]]; then
    wget -q "$SFALL_URL" -O "$SFALL_ARCHIVE"
fi
7z e -y "$SFALL_ARCHIVE" ddraw.dll

# Normalize timestamps for reproducible ZIP archives
fix-timestamp ddraw.dll "$MODS_DIR"
zip -rX "${MOD_NAME}_${VERSION}.zip" ddraw.dll "$MODS_DIR/"

# Restore only the po directory that was deleted
git checkout -- data/text/po

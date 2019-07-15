#!/bin/bash

set -xeu -o pipefail

# exit with 0 if need to build
TRAVIS_TAG=${TRAVIS_TAG:-}

if [[ -n "$TRAVIS_TAG" ]]; then
  exit 0
fi

TRAVIS_COMMIT_RANGE=${TRAVIS_COMMIT_RANGE:-}
if git diff --name-only $TRAVIS_COMMIT_RANGE | grep -qv "docs\|README.md" ; then
  exit 0
fi

exit 1

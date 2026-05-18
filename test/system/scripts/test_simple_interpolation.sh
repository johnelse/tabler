#!/bin/bash

set -eu

echo "Running simple interpolation system tests"

WORK=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXX")
mkdir -p "$WORK"

function cleanup() {
    rm -rf "$WORK"
}
trap cleanup EXIT

../../bin/tabler.exe --start=sine --end="math.sin(3 * theta)" "$WORK/interpolation.wav"
cmp data/interpolation.wav "$WORK/interpolation.wav"

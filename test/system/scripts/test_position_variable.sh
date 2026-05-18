#!/bin/bash

set -eu

echo "Running position variable system tests"

WORK=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXX")
mkdir -p "$WORK"

function cleanup() {
    rm -rf "$WORK"
}
trap cleanup EXIT

../../bin/tabler.exe --start="(1 - 0.5 * position) * math.sin(theta) + 0.5 * position * math.sin(3 * theta)" "$WORK/position.wav"
cmp data/position.wav "$WORK/position.wav"
echo "OK"

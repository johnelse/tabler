#!/bin/bash

set -eu

echo "Running single-cycle system tests"

WORK=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXX")
mkdir -p "$WORK"

function cleanup() {
    rm -rf "$WORK"
}
trap cleanup EXIT

WAVES=("sine" "square" "triangle")

for WAVE in ${WAVES[@]}
do
    ../../bin/tabler.exe --single-cycle=$WAVE "$WORK/single_cycle_${WAVE}.wav"
    cmp data/single_cycle_${WAVE}.wav "$WORK/single_cycle_${WAVE}.wav"
done

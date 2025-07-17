#!/bin/bash
# Usage: run_oclint_metadata.sh input_targets output_file
output="$1"

# Locate the oclint binary relative to runfiles
oclint_path=$(find "$(dirname "$0")/.." -name "oclint-22.02" | head -n 1)

version=$($oclint_path --version | grep version | xargs)
echo "{\"version\": \"$version\"}" > "$output" || true

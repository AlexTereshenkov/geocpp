#!/bin/bash
# Usage: run_oclint.sh input output
input="$1"
output="$2"

# Locate the oclint binary relative to runfiles
oclint_path=$(find "$(dirname "$0")/.." -name "oclint-22.02" | head -n 1)
# Locate the compilation database relative to runfiles
compilation_db=$(find "$(dirname "$0")/.." -name "compile_commands.json" | head -n 1)

$oclint_path -p="$compilation_db" "$input" > "$output" || true

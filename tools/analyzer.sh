#!/bin/bash
# Usage: analyzer.sh input_file output_file
input="$1"
output="$2"
sleep 3
wc -l "$input" > "$output"

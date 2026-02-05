#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <directory_path>"
  exit 1
fi

dir="$1"

if [ ! -d "$dir" ]; then
  echo "Error: Not a directory: $dir"
  exit 1
fi

mkdir -p "$dir/backup"

echo "Script PID (this script): $$"

pids=()

for f in "$dir"/*; do
  if [ -f "$f" ]; then
    mv "$f" "$dir/backup/" &
    pid=$!
    echo "Moving $(basename "$f") in background. PID: $pid"
    pids+=("$pid")
  fi
done

echo "Waiting for all background move processes..."
wait
echo "All background moves completed."

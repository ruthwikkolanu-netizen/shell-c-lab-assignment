#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <dirA> <dirB>"
  exit 1
fi

dirA="$1"
dirB="$2"

if [ ! -d "$dirA" ] || [ ! -d "$dirB" ]; then
  echo "Error: Both arguments must be existing directories."
  exit 1
fi

echo "Files only in $dirA:"
comm -23 <(ls -1 "$dirA" | sort) <(ls -1 "$dirB" | sort)

echo ""
echo "Files only in $dirB:"
comm -13 <(ls -1 "$dirA" | sort) <(ls -1 "$dirB" | sort)

echo ""
echo "Common files content comparison:"
common_files=$(comm -12 <(ls -1 "$dirA" | sort) <(ls -1 "$dirB" | sort))

for f in $common_files; do
  if [ -f "$dirA/$f" ] && [ -f "$dirB/$f" ]; then
    if cmp -s "$dirA/$f" "$dirB/$f"; then
      echo "$f : MATCH"
    else
      echo "$f : DIFFER"
    fi
  fi
done

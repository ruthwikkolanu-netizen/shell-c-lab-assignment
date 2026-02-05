#!/bin/bash

input="emails.txt"

if [ ! -r "$input" ]; then
  echo "Error: emails.txt not found or not readable."
  exit 1
fi

# Valid pattern: letters/digits @ letters .com
valid_regex='^[A-Za-z0-9]+@[A-Za-z]+\.com$'

# Extract valid and invalid
grep -E "$valid_regex" "$input" > valid.txt
grep -Ev "$valid_regex" "$input" > invalid.txt

# Remove duplicates from valid.txt
sort valid.txt | uniq > valid_unique.txt
mv valid_unique.txt valid.txt

echo "Done."
echo "Valid emails saved in valid.txt (duplicates removed)."
echo "Invalid emails saved in invalid.txt."

#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Error: Provide exactly one argument."
    exit 1
fi

path="$1"

if [ ! -e "$path" ]; then
    echo "Error: Path does not exist."
    exit 1
fi

if [ -f "$path" ]; then
    echo "It is a file."
    echo "Lines Words Characters:"
    wc "$path"

elif [ -d "$path" ]; then
    echo "It is a directory."

    total_files=$(find "$path" -type f | wc -l)
    txt_files=$(find "$path" -type f -name "*.txt" | wc -l)

    echo "Total files: $total_files"
    echo ".txt files: $txt_files"

else
    echo "Invalid input."
fi

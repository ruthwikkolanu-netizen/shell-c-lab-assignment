#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

file="$1"

if [ ! -r "$file" ]; then
    echo "Error: File not found or not readable."
    exit 1
fi

> vowels.txt
> consonants.txt
> mixed.txt

while read word
do
    clean=$(echo "$word" | tr 'A-Z' 'a-z' | tr -cd 'a-z')

    if echo "$clean" | grep -Eq '^[aeiou]+$'; then
        echo "$word" >> vowels.txt

    elif echo "$clean" | grep -Eq '^[bcdfghjklmnpqrstvwxyz]+$'; then
        echo "$word" >> consonants.txt

    else
        if echo "$clean" | grep -Eq '^[bcdfghjklmnpqrstvwxyz]' \
        && echo "$clean" | grep -Eq '[aeiou]' \
        && echo "$clean" | grep -Eq '[bcdfghjklmnpqrstvwxyz]'; then
            echo "$word" >> mixed.txt
        fi
    fi

done < "$file"

echo "Processing completed."

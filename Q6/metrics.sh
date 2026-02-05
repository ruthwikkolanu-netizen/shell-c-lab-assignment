#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input.txt>"
    exit 1
fi

file="$1"

if [ ! -r "$file" ]; then
    echo "Error: File not found or not readable."
    exit 1
fi

# Extract words only and convert to lowercase
words=$(tr -cs 'A-Za-z' '\n' < "$file" | tr 'A-Z' 'a-z')

# Longest word
longest=$(echo "$words" | awk 'length>max{max=length;word=$0} END{print word}')

# Shortest word
shortest=$(echo "$words" | awk 'NR==1{min=length($0);word=$0} length($0)<min{min=length($0);word=$0} END{print word}')

# Average word length
average=$(echo "$words" | awk '{sum+=length($0); count++} END{if(count>0) printf "%.2f", sum/count}')

# Unique word count
unique=$(echo "$words" | sort | uniq | wc -l)

echo "Longest word: $longest"
echo "Shortest word: $shortest"
echo "Average word length: $average"
echo "Total unique words: $unique"

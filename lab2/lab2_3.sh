# 2.3
# Write a shell script that takes as a command-line argument a path to a source directory.

# The source directory contains text files. The script should process only the files that satisfy the following conditions:

# - they are regular files
# - they have a .txt extension
# - their filename contains at least one digit
# - others have read permission for the file

# The script should create a directory named processed in the current working directory.

# For each file that satisfies the conditions, a new file should be created in the processed directory with the same name, but with the extension .out instead of .txt.

# Each .out file should contain all unique words from the corresponding input file that satisfy the following conditions:

# - the word contains only letters from the English alphabet
# - the word is treated case-insensitively
# - all words in the output should be written in lowercase
# - each word should appear only once
# - the words should be sorted in alphabetical order

# A “word” is defined as any sequence obtained by splitting the text by spaces and punctuation.

# Additionally, the script should create a file named summary.txt in the current working directory with exactly the following format:

# processedFiles: X
# totalUniqueWords: Y
# fileWithMostUniqueWords: Z
# maxUniqueWords: W

# where:
# - X is the number of processed files
# - Y is the total number of unique words across all generated .out files
# - Z is the name of the file (original .txt name) that has the most unique words
# - W is the number of unique words in that file

# Additional requirements:

# - If exactly one argument is not provided, print:
#   Usage: ./script.sh <source_directory>
# - If the directory does not exist, print:
#   Error: source directory does not exist
# - If there are no files that satisfy the conditions, the script should still create processed and summary.txt
# - In that case, summary.txt should contain:
#   processedFiles: 0
#   totalUniqueWords: 0
#   fileWithMostUniqueWords: none
#   maxUniqueWords: 0
# - Temporary files must not be used


#!/bin/bash

# Proverka na argument
if [ "$#" -ne 1 ]; then
    echo "Usage: ./script.sh <source_directory>"
    exit 1
fi

# Proverka dali postoi direktorium
if [ ! -d "$1" ]; then
    echo "Error: source directory does not exist"
    exit 1
fi

# Kreiraj direktorium'
OUTDIR="./processed"
mkdir -p "$OUTDIR"

processedFiles=0
totalUniqueWords=0
maxUniqueWords=0
fileWithMostUniqueWords="none"

# Loop niz datoteki
for file in "$1"/*[0-9].txt; do
    filename=$(basename "$file")
    
    # Proverka dali e regularna datoteka i dali 'others' mozhe da prochitaat
    if [ ! -f "$file" ] || [ ! -r "$file" ]; then
        continue
    fi

    # Proverka na uslovi
    perm=$(ls -l $file | cut -c8)
	if [ ! "$perm" = "r" ]; then
		continue
	fi

    outFile="$OUTDIR/${filename%.txt}.out"

    # Obrabotka na unikatni zborovi
    uniqueWords=$(tr -c 'A-Za-z' '\n' < "$file" \
        | tr 'A-Z' 'a-z' \
        | grep -E '^[a-z]+$' \
        | sort -u)

    # Zapishi vo soodvetna out datoteka
    echo "$uniqueWords" > "$outFile"

    # Broj na zborovi vo ovaa datoteka
    count=$(echo "$uniqueWords" | grep -c .)

    # Promeni statistika
    processedFiles=$((processedFiles + 1))
    totalUniqueWords=$((totalUniqueWords + count))

    # Proverka za datoteka so najgolem broj na unikatni zborovi
    if [ "$count" -gt "$maxUniqueWords" ]; then
        maxUniqueWords="$count"
        fileWithMostUniqueWords="$filename"
    fi
done

# Zapishi vo summary.txt
echo "processedFiles: $processedFiles" > summary.txt
echo "totalUniqueWords: $totalUniqueWords" >> summary.txt
echo "fileWithMostUniqueWords: $fileWithMostUniqueWords" >> summary.txt
echo "maxUniqueWords: $maxUniqueWords" >> summary.txt
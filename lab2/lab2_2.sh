# 2.2
# Write a shell script that copies all files that satisfy the following conditions:

# - They have a .csv extension
# - Their filename contains at least one digit
# - Others have read permission for the file

# Requirements:

# - The source directory is provided as a command-line argument.
# - The script should create a directory named copiedFiles in the current working directory.
# - All files that satisfy the conditions should be copied into this directory.

# Additionally, a file named statistics.txt should be created, containing:

# - Total number of copied files
# - Total size (in bytes)
# - Total number of lines
# - Size of the largest file
# - Name of the largest file

# The format of statistics.txt should be exactly:

# copiedFiles: X
# totalSize: Y
# totalNumberOfLines: Z
# largestFile: A
# longestName: B

#!/bin/bash

# Proverka za argument
if [ ! $# -eq 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DESTINATION="./copiedFiles"

# Kreiraj direktorium
mkdir -p "$DESTINATION"

copiedFiles=0
totalSize=0
totalNumberOfLines=0
largestFile=0
longestName=""

# Loop niz .csv datoteki
for file in "$1"/*[0-9].csv; do
    # Proverka dali postoi barem edna .csv datoteka
    [ -e "$file" ] || break

    # Zemi go imeto na datotekata
    filename=$(basename "$file")

    # Proverka: za read permisii na "other"
    perm=$(ls -l $file | cut -c8)
	if [ ! "$perm" = "r" ]; then
		continue
	fi

    # Zgolemi brojot na datoteki za edno
    copiedFiles=$(($copiedFiles + 1))

    # Kopiraj ja datotekata vo destinaciskiot direktorium
    cp "$file" "$DESTINATION"

    # Najdi golemina na datotekata
    size=$(ls -l $file | awk '{ print $5 }')

    # Najdi broj na linii na datotekata
    lines=$(wc -l < "$file")

    # Promeni statistika
    totalSize=$(($totalSize + $size))
    totalNumberOfLines=$(($totalNumberOfLines + $lines))

    # Proverka za dali ovaa datoteka e najgolema
    if [ "$size" -gt "$largestFile" ]; then
        largestFile=$size
    fi

    # Proverka za imeto na ovaa datoteka dali e najdolgo
    len=${#filename}
    if [ "$len" -gt "${#longestName}" ]; then
        longestName="$filename"
    fi
done

# Zapishi vo datoteka statistics.txt
stats="statistics.txt"
echo "copiedFiles: $copiedFiles" > "$stats"
echo "totalSize: $totalSize" >> "$stats"
echo "totalNumberOfLines: $totalNumberOfLines" >> "$stats"
echo "largestFile: $largestFile" >> "$stats"
echo "longestName: $longestName" >> "$stats"
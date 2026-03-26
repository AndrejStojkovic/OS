# 2.LAB
# Same as Lab 2.3, but instead of puttin unique words in the .out files
# You are required to put the longest and shortest word in that .txt file

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

    # Inicijaliziraj promenlivi
    najkratokZbor=""
    najkratokLen=1000000

    najdolgZbor=""
    najdolgLen=-1

    # Pomini go sekoj zbor individualno i najdi dali e najgolem ili najkratok
    for word in $(<"$file")
    do
        len=${#word}

	# Dokolku najdeme "zbor" so pomalce od eden karakter, prodolzhi so drugite
	if (( len < 1 ))
	then
	    continue
	fi

        if (( len > najdolgLen ))
        then
            najdolgZbor="${word}"
	    najdolgLen=${len}
	fi

	if (( len < najkratokLen ))
	then
	    najkratokZbor="${word}"
	    najkratokLen=${len}
        fi
    done

    # Zapishi vo datoteka
    echo "Najkratok zbor: ${najkratokZbor}" > "$outFile"
    echo "Najdolg zbor: ${najdolgZbor}" >> "$outFile"

    # Promeni statistika
    processedFiles=$((processedFiles + 1))
done

# Zapishi vo summary.txt
echo "processedFiles: $processedFiles" > summary.txt

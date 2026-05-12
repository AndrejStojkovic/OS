# Lab 1 - Group A

# .
# .
# .
# .
# .
# .

# 1.
mkdir directory1 directory2 && touch directory1/file123

# 2.
chmod 550 hello_world.py

# 3.
mv directory1/file123 directory2/file456

# 4.
cat OS1.txt OS2.txt

# 5. Ovaa bi mozhela i so 'cut' ama ne raboti kaj mene toaa
awk '{print $1, $4}' OS1.txt OS2.txt

# 6.
wc OS1.txt

# 7.
grep '^22' OS1.txt

# 8.
awk '$1 ~ /^23/ && $4 > 50 { print $1, $2, $4 ; }' OS1.txt

# 9.
awk '$2 == "14.03.2024" && $3 == "in_progress" {count++} END {print count}'

# 10.
awk '$1 ~ /^tcp/ && $6 != "" { count[$6]++; } END { for (s in count) printf "%-20s %s\n", s, count[s] }' | sort -k2 -rn

# Additional
awk -F, '$5 == "Female" && $8 ~ /^20/ { print $3, $4, $5, $8; count++; } END { print count; }' file.csv
awk -F, '$5 == "Male" && $8 ~ /^20/ { print $3, $4, $5, $8; count++; } END { print count; }' file.csv
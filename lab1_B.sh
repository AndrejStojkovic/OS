# Lab 1 - Group B

# .
# .
# .
# .
# .
# .

# 1.
mkdir directory1 directory2 && touch directory1/file123

# 2.
chmod 660 hello_world.py

# 3.
mv directory1/file123 directory2/file456

# 4.
cat OS1.txt OS2.txt

# 5.
awk '{print $1, $3}' OS1.txt OS2.txt

# 6.
wc OS2.txt

# 7.
awk '$1 ~ /^21/ { print; }' OS2.txt

# 8.
awk '$1 ~ /^22/ && $4 < 50 { print $1, $2, $4; }' OS2.txt

# 9.
awk '$2 == "14.03.2024" && $3 == "in_progress" { count++; } END { print count; }'

# 10.
awk '$1 != "" && $1 != "USER" { count[$1]++; } END { for(str in count) printf "%20-s %s\n", str, count[str]; }' | sort -k2 -rn
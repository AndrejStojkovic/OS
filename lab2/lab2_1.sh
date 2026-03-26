# 2.1
# Write a shell script that, for data entered through standard input
# (in the format of the output of the command netstat -an, prints to standard output
# the number of TCP connections for each local address (IP without port).

# Each line of the output should be in the format: "%-20s %s\n",
# where the first argument is the local IP address (without port),
# and the second is the number of TCP connections for that address.

# The output should be sorted:
# - in descending order by the number of connections
# - for equal values, in ascending order by the IP address

# Additional requirements:
# - Only TCP connections should be considered (tcp and tcp6)
# - Header lines should be ignored
# - The port should be removed (e.g., 0.0.0.0:80 → 0.0.0.0)
# - Use awk, sort and uniq (or an equivalent solution using awk)
# - Do not use temporary files
# - The script must read exclusively from standard input (stdin)


#!/bin/bash

awk '
/^tcp/ {
    local_addr = $4
    if (local_addr ~ /^:::/) {
        local_addr = ":::"
    } else {
        sub(/:[^:]*$/, "", local_addr)
    }
    count[local_addr]++
}
END {
    for (ip in count) {
        printf "%-20s %s\n", ip, count[ip]
    }
}
'| sort -k2,2nr -k1,1
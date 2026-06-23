#!/bin/bash
# Usage:
#   ./create-project-port.sh <name>             → single port
#   ./create-project-port.sh <name1> <name2> …  → sorted table + collision check

projectPort() {
    local name="$1"
    local hash=0 i c code
    for ((i = 0; i < ${#name}; i++)); do
        c="${name:$i:1}"
        printf -v code '%d' "'$c"
        hash=$(( (hash * 31 + code) & 0xFFFFFFFF ))
    done
    echo $((10000 + (hash % 10000)))
}

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <name> [name2 ...]" >&2
    exit 1
elif [ "$#" -eq 1 ]; then
    projectPort "$1"
else
    rows=""
    for name in "$@"; do
        port=$(projectPort "$name")
        rows="$rows$port $name\n"
    done

    sorted=$(printf "$rows" | sort -n)

    echo "=== All Ports ==="
    echo "$sorted"

    echo ""
    dupes=$(echo "$sorted" | awk '{print $1}' | sort | uniq -d)
    if [ -z "$dupes" ]; then
        echo "No collisions detected."
    else
        echo "=== COLLISIONS ==="
        while IFS= read -r port; do
            names=$(echo "$sorted" | awk -v p="$port" '$1==p {print $2}' | tr '\n' ' ')
            echo "PORT $port: $names"
        done <<< "$dupes"
    fi
fi

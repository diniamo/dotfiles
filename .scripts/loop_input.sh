#!/bin/bash

echo "Command: $1 <input>"

while true; do
    read -p "❯ " -r -e user_input

    if [ "$user_input" = "exit" ]; then
        exit 0
    fi

    $1 "$user_input"
done

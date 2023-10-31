#!/bin/sh

echo "Command: $1 <input>"

while true; do
    echo -n "> "
    read -r user_input

    if [ "$user_input" = "exit" ]; then
        echo "Exiting the script."
        break
    fi

    "$1" "$user_input"
done

#!/bin/bash

# Prompt the user to enter the filename for the wordlist
read -p "Enter the filename for the wordlist (default: /usr/share/wordlists/rockyou.txt): " wordlist
wordlist=${wordlist:-/usr/share/wordlists/rockyou.txt}

# Prompt the user to enter the capture file
read -p "Enter the capture file: " capture_file

# Run the aircrack-ng command with the provided wordlist and capture file
sudo aircrack-ng -w "$wordlist" "$capture_file"
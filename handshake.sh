#!/bin/bash

# Prompt the user to enter the MAC address
read -p "Enter the MAC address: " mac_address

# Prompt the user to enter the network interface, default to wlan0mon if no input
read -p "Enter the network interface (default: wlan0mon): " interface
interface=${interface:-wlan0mon}

# Prompt the user to enter the file name for the capture
read -p "Enter the file name for the capture: " file_name

# Run the airodump-ng command with the provided MAC address, interface, and file name
sudo airodump-ng -w "$file_name" --bssid "$mac_address" "$interface"
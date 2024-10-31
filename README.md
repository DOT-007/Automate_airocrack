# Automate_airocrack
## Explanation
Tool Check: Confirms both airodump-ng and aireplay-ng are installed.
AP MAC and Client MAC Prompt: Collects MAC addresses for the AP and (optionally) a client.
Channel and Interface Prompt: Asks for the channel and monitor-mode wireless interface.
Capture File Setup: Starts airodump-ng and saves the output to a .cap file with a timestamped name.
Optional Deauth Attack: Sends deauth packets to the client MAC to trigger a handshake if a client MAC is provided.
Capture Stopping Reminder: Advises the user to stop the capture manually.
Usage
Make the script executable:

bash
Copy code
```
chmod +x airo.sh
```
Run the script:

bash
Copy code
```
./airo.sh
```
Note: Only use this script on networks where you have authorization. Unauthorized access to networks is illegal.







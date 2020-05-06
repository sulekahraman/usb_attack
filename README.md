# 6.858 Final Project Spring 2020 
## Plugging in a USB: What's the Worst That Could Happen?
This repo contains our implementation of a sophisticated HID (Human Interface Device) spoofing attack where the device is a USB stick that tricks the computer into thinking it is a keyboard. When plugged into a computer, it injects keystrokes to open the command line on the computer and allows for various exploits. One exploit we explored is automatically sending important files to the attacker server. 

## Components
### USB Configuration

### Attacker Server
The attacker server is always available and ready to receive files so that when the victim plugs in the attackerUSB, the attacker can immediately get access to the victim's computer. We set up an FTP server on a Google Cloud virtual machine to ensure the availability of the server and to easily modify network rules. The detailed steps can be found For the safety of the attacker server, we check the credentials of the requested connection. We only allow connections requested by the attackerUSB by checking whether the login credentials match those of the attackerUSB. 

**attacker_server** folder contains the details about how to setup an FTP server on Google Cloud and configure networking to be able to communicate with the attackerUSB from any computer. 

### Malicious Scripts


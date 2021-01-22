# Windows 10 Quick Fix
A more complex script to run DISM and or SFC with prompts because I can't remember the full DISM command.

Currently it runs DISM /Online /Cleanup-Image /RestoreHealth and or SFC /scannow via a menu.

To run you'll need to start PowerShell as Admin and run ```Set-ExecutionPolicy RemoteSigned``` if PowerShell has not been configured previously to run scripts.

The file will also need to be unblocked by changing to the directory the script is in and running ```Unblock-File -Path "./Microsoft Windows 10 Quick Fix.ps1"```.

Right click on "Microsoft Windows 10 Quick Fix.ps1" and click Run With PowerShell.

Follow the prompts.

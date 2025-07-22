param([switch]$Elevated)

function testAdmin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((testAdmin) -eq $false)  {
    if ($elevated) {
        Please allow elevation to run properly.
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

Clear-Host

$title = "Windows 10/11 Quick Fix"
$host.UI.RawUI.WindowTitle = $title

Write-Host $title
Write-Host "`n"
Write-Host "========================================================================================================="
Write-Host "Runs Deployment Image Servicing And Management RestoreHealth And System File Checker With Scannow Switch."
Write-Host "========================================================================================================="
Write-Host "`n"

# Version 1.00

# Main menu, allowing user selection
function Show-Menu {
    Write-Host "================ $title ================"
    Write-Host "1: Press '1' To Run Deployment Image Servicing And Management With Online Cleanup-Image And RestoreHealth Switches."
    Write-Host "2: Press '2' To Run System File Checker With Scannow Switch."
    Write-Host "A: Press 'A' To Run All."
    Write-Host "Q: Press 'Q' To Quit."
    Write-Host "`n"
}

function runDISM {
    DISM /Online /Cleanup-Image /RestoreHealth
    Write-Host "`n"
}

function runSFC {
    SFC /scannow
    Write-Host "`n"
}

function runAll {
    runDISM
    runSFC
}

#Main menu loop
do {
    Show-Menu
    $userInput = Read-Host "Please make a selection"
    Write-Host "`n"
    switch ($userInput) {
         '1' {
            runDISM
        } '2' {
            runSFC
        } 'a' {
            runAll
        } 'q' {
            stop-process -Id $PID
        }
    }
    pause
    Write-Host "`n"
}
until ($userInput -eq 'q')
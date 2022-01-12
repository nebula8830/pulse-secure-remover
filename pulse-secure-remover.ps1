$ErrorActionPreference = 'silentlycontinue' #no shown errors looks pretty

#variables
$linespace = "
_______________________________________
"
$todelete1 = "${env:ALLUSERSPROFILE}\Pulse Secure"
$todelete2 = "${env:ProgramFiles(x86)}\Common Files\Pulse Secure"
$todelete3 = "${env:ProgramFiles(x86)}\Pulse Secure"
$todelete4 = "${env:PUBLIC}\Pulse Secure"
$todelete5 = 'AppData\Local\Pulse Secure'
$todelete6 = 'AppData\Roaming\Pulse Secure'

Write-Host $linespace   #decoration

#admin check
if ($null -eq ${env:=::}) {
    Write-Host 'Admin Check Complete'
}
else {
    Write-Host -BackgroundColor Red '!!!!    Not Admin   !!!!'
    Write-Host -BackgroundColor Red 'Please right click pulse-secure-remover.exe, then click "Run as admininstrator"'
    Write-Host -BackgroundColor Red "Press any key to close..."
    Write-Host $linespace   #decoration
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") #wait before exit
    exit
}

#todelete1
Remove-Item $todelete1 -Recurse -Force -Confirm:$false
Write-Host "Deleted $todelete1"

#todelete2
Remove-Item $todelete2 -Recurse -Force -Confirm:$false
Write-Host "Deleted $todelete2"

#todelete3
Remove-Item $todelete3 -Recurse -Force -Confirm:$false
Write-Host "Deleted $todelete3"

#todelete4
Remove-Item $todelete4 -Recurse -Force -Confirm:$false
Write-Host "Deleted $todelete4"

#todelete5&6
$users = Get-ChildItem c:\users | Where-Object { $_.PSIsContainer }
foreach ($user in $users) {
    $userpathA = "C:\Users\$user\$todelete5"
    $userpathB = "C:\Users\$user\$todelete6"
    Remove-Item $userpathA -Recurse -Force -Confirm:$false
    Remove-Item $userpathB -Recurse -Force -Confirm:$false
}
Write-Host "Deleted C:\Users\*\$todelete5"
Write-Host "Deleted C:\Users\*\$todelete6"

Write-Host $linespace   #decoration

#gives user time to look before exit
Write-Host "Done, Press any key to close..."
Write-Host $linespace   #decoration
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
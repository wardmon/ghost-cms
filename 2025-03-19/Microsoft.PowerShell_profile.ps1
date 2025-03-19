Import-Module scoop-completion

#[System.onsole]::OutputEncoding = [System.Console]::InputEncoding = [System.Text.Encoding]::UTF8
Get-History | Export-Clixml -Path "g:\history.xml"
cp C:\Users\null3\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt G:\obsidiandata\ghost-cms\SingleFile-dockerized\pdf\ConsoleHost_history.txt






# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

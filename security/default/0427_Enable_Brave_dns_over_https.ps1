# Path to Brave executable (adjust if installed elsewhere)
$bravePath = "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"

# Path where you want to create the shortcut (here, Desktop)
$shortcutPath = "$env:USERPROFILE\Desktop\BraveDNS.lnk"

# Create a WScript.Shell COM object to handle the shortcut creation
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut($shortcutPath)

# Set the target path and add command-line arguments to enable DoH with CIRA Canada
$shortcut.TargetPath = $bravePath
$shortcut.Arguments = '--enable-dns-over-https --dns-over-https-mode=secure --dns-over-https-servers="https://doh.cira.ca/dns-query"'

# Save the shortcut
$shortcut.Save()

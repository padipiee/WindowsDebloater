# https://www.bleepingcomputer.com/tutorials/how-to-enable-kernel-mode-hardware-enforced-stack-protection-in-windows-11/
# Enable Kernel-mode Hardware-enforced Stack Protection
$currentValue = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "EnableKernelModeStackProtection" -ErrorAction SilentlyContinue)."EnableKernelModeStackProtection"
if ($currentValue -ne 1) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "EnableKernelModeStackProtection" -Value 1
    Write-Host "Kernel-mode hardware-enforced stack protection enabled."
} else {
    Write-Host "Kernel-mode hardware-enforced stack protection is already enabled."
}

# Restart the computer to apply the changes
#Restart-Computer

# https://www.bleepingcomputer.com/tutorials/how-to-enable-kernel-mode-hardware-enforced-stack-protection-in-windows-11/
# Enable Kernel-mode Hardware-enforced Stack Protection
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "EnableKernelModeStackProtection" -Value 1

# Restart the computer to apply the changes
#Restart-Computer

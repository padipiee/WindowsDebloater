#Modify the registry key to reduce Windows 11 memory usage

<#
.SYNOPSIS
Adjusts the ClearPageFileAtShutDown property in the Windows registry.

.DESCRIPTION
This script modifies the ClearPageFileAtShutDown property in the Windows registry to control whether the page file is cleared at system shutdown. By default, the value is set to 0 (disabled), but this script sets it to 1 (enabled).

.PARAMETER registryPath
The path to the registry key where the property is located. The default path is "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management".

.PARAMETER propertyName
The name of the property to modify. The default property name is "ClearPageFileAtShutDown".

.PARAMETER newValue
The new value for the property. The default value is 1.

.EXAMPLE
Adjust-ClearPageFileAtShutdown

This example adjusts the ClearPageFileAtShutDown property in the Windows registry using the default values.

.EXAMPLE
Adjust-ClearPageFileAtShutdown -registryPath "HKLM:\SOFTWARE\MyApp" -propertyName "CustomProperty" -newValue 0

This example adjusts a custom property named "CustomProperty" in the registry path "HKLM:\SOFTWARE\MyApp" with a new value of 0.

#>


# Define the path to the registry key
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"

# Define the name of the property to modify
$propertyName = "ClearPageFileAtShutDown"

# Define the new value for the property
$newValue = 1

# Check if the registry key exists
if (Test-Path -Path $registryPath) {
    # Get the current value of the property
    $currentValue = (Get-ItemProperty -Path $registryPath).$propertyName

    if ($currentValue -eq $newValue) {
        Write-Output "No modification needed. The $propertyName is already set to $newValue."
    } else {
        # Modify the property
        Set-ItemProperty -Path $registryPath -Name $propertyName -Value $newValue
        Write-Output "The $propertyName has been set to $newValue."
    }
} else {
    Write-Output "Registry path $registryPath does not exist."
}
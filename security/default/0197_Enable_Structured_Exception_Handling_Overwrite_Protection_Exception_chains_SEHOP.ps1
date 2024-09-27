<#
.SYNOPSIS
Enable Structured Exception Handling Overwrite Protection (SEHOP).

.DESCRIPTION
This script enables the Structured Exception Handling Overwrite Protection (SEHOP) feature in Windows.
 SEHOP is designed to block exploits that use the Structured Exception Handler (SEH) overwrite technique, 
 providing runtime protection for applications regardless of whether they have been compiled with the latest improvements.

.PARAMETER None

.INPUTS
None. You cannot pipe objects to this script.

.OUTPUTS
None. This script does not generate any output.

.EXAMPLE
...

.NOTES
Author: 
Date:
Version: 1.0
#>
# :: Enable_Structured_Exception_Handling_Overwrite_Protection_(SEHOP).bat
# :: enable Structured Exception Handling Overwrite Protection (SEHOP)
# :: This feature is designed to block exploits that use the Structured Exception Handler (SEH) overwrite technique. This protection mechanism is provided at run-time. 
# :: Therefore, it helps protect applications regardless of whether they have been compiled with the latest improvements, such as the /SAFESEH option
# :: https://support.microsoft.com/en-us/topic/how-to-enable-structured-exception-handling-overwrite-protection-sehop-in-windows-operating-systems-8d4595f7-827f-72ee-8c34-fa8e0fe7b915

# :: Windows Security >> App & Browser control >> Exploit protection settings >> Validate exeception chains
# :: Ensures the integrity of an exception chain during dispatch

#:: https://www.ghacks.net/2012/07/16/advanced-windows-security-activating-sehop/
#:: https://www.stigviewer.com/stig/windows_8_8.1/2016-06-08/finding/V-68847

# Set the values for the properties
$PATHSEHOP = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"
$PROPERTYSEHOP = "DisableExceptionChainValidation"
$VALUESEHOP = 0

# Step 1: Check if the parent registry path exists
$parentPath = Split-Path -Path $PATHSEHOP -Parent
if (-not (Test-Path -Path $parentPath)) {
    Write-Host "Step 1: Error: The parent registry path $parentPath does not exist."
    exit 1
} else {
    Write-Host "Step 1: Parent registry path $parentPath exists."
}

# Step 2: Check if the registry path exists
if (-not (Test-Path -Path $PATHSEHOP)) {
    Write-Host "Step 2: Error: The registry path $PATHSEHOP does not exist."
    exit 1
} else {
    Write-Host "Step 2: Registry path $PATHSEHOP exists."
}

# Step 3: Test the property existence
try {
    $existingValue = Get-ItemProperty -Path $PATHSEHOP -Name $PROPERTYSEHOP -ErrorAction Stop
    Write-Host "Step 3: Property [$PROPERTYSEHOP] exists."
} catch {
    $existingValue = $null
    Write-Host "Step 3: Property [$PROPERTYSEHOP] does not exist and will be created..."
}

# Step 4: Evaluate property value
if ($existingValue -and $existingValue.$PROPERTYSEHOP -eq $VALUESEHOP) {
    Write-Host "Step 4: Property [$PROPERTYSEHOP] is already set to $VALUESEHOP. No modification needed. Exiting..."
    exit 0
} else {
    Write-Host "Step 4: Property [$PROPERTYSEHOP] to be created or modified..."
}

# Step 5: Try to set the property if needed
try {
    Set-ItemProperty -Path $PATHSEHOP -Name $PROPERTYSEHOP -Value $VALUESEHOP -ErrorAction Stop
    Write-Host "Step 5: Property [$PROPERTYSEHOP] set to $VALUESEHOP."
    exit 0
} catch {
    Write-Host "Step 5: Error: Unable to set the property [$PROPERTYSEHOP] to $VALUESEHOP."
    exit 1
}

# Step 6: Test the existence and value of the registry in case of success
try {
    $updatedValue = Get-ItemProperty -Path $PATHSEHOP -Name $PROPERTYSEHOP -ErrorAction Stop
    if ($updatedValue -and $updatedValue.$PROPERTYSEHOP -eq $VALUESEHOP) {
        Write-Host "Step 6: Property [$PROPERTYSEHOP] exists and is set to $VALUESEHOP."
    } else {
        Write-Host "Step 6: Error: Property [$PROPERTYSEHOP] does not exist or has an incorrect value."
    }
} catch {
    Write-Host "Step 6: Error: Unable to retrieve the property [$PROPERTYSEHOP] from the registry."
}



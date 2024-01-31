#   Description:
# This script creates a folder called "God Mode" on the current user's desktop. The folder has a special GUID that allows access to various system settings and options in one place.
# 
#   Parameters:
#   None
# 
#   Example:
#   Enable-GodMode
# 
#   Notes:
#   - This script requires administrative privileges to create the folder on the desktop.
#   - The "God Mode" folder can be accessed by double-clicking on it and provides a convenient way to access various system settings and options.
#   - The GUID used for the folder name is "{ED7BA470-8E54-465E-825C-99712043E01C}".
#   - The folder is created on the current user's desktop using the GetFolderPath method from the Environment class.
#   - If the folder already exists, the script will not create a new one.
#   Description:
# This scripts places the "God Mode" folder on the current user's desktop.


$DesktopPath = [Environment]::GetFolderPath("Desktop");
mkdir "$DesktopPath\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
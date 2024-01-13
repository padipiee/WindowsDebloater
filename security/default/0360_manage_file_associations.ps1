# Change file associations to protect against common ransomware and social engineering attacks. 
# Be aware that this might break some functionality and adapt to your needs.

###A ##

## B ##
#Set-ItemProperty -Path "HKCU:\Software\Classes\.bat" -Name "(default)" -Value "txtfile"

## C ##
#Set-ItemProperty -Path "HKCU:\Software\Classes\.cmd" -Name "(default)" -Value "txtfile"
Set-ItemProperty -Path "HKCU:\Software\Classes\.chm" -Name "(default)" -Value "txtfile"

## D ##
Set-ItemProperty -Path "HKCU:\Software\Classes\.diff" -Name "(default)" -Value "txtfile"

## E ## 

## F ##

## G ##

## H ##
Set-ItemProperty -Path "HKCU:\Software\Classes\.hta" -Name "(default)" -Value "txtfile"

## I ##
#Set-ItemProperty -Path "HKCU:\Software\Classes\.iso" -Name "(default)" -Value "txtfile"
Set-ItemProperty -Path "HKCU:\Software\Classes\.iqy" -Name "(default)" -Value "txtfile"

## J ##

Set-ItemProperty -Path "HKCU:\Software\Classes\.jse" -Name "(default)" -Value "txtfile"
#Set-ItemProperty -Path "HKCU:\Software\Classes\.js" -Name "(default)" -Value "txtfile"

## M ## 
Set-ItemProperty -Path "HKCU:\Software\Classes\.msc" -Name "(default)" -Value "txtfile"

## P ## 
#Set-ItemProperty -Path "HKCU:\Software\Classes\.ps1" -Name "(default)" -Value "txtfile"
Set-ItemProperty -Path "HKCU:\Software\Classes\.prn" -Name "(default)" -Value "txtfile"


## R ##
#Set-ItemProperty -Path "HKCU:\Software\Classes\.reg" -Name "(default)" -Value "txtfile"

## S ##
Set-ItemProperty -Path "HKCU:\Software\Classes\.slk" -Name "(default)" -Value "txtfile"

## V ##
Set-ItemProperty -Path "HKCU:\Software\Classes\.vbe" -Name "(default)" -Value "txtfile"
Set-ItemProperty -Path "HKCU:\Software\Classes\.vbs" -Name "(default)" -Value "txtfile"

## W ##
Set-ItemProperty -Path "HKCU:\Software\Classes\.wsc" -Name "(default)" -Value "txtfile"
Set-ItemProperty -Path "HKCU:\Software\Classes\.wsf" -Name "(default)" -Value "txtfile"
Set-ItemProperty -Path "HKCU:\Software\Classes\.ws" -Name "(default)" -Value "txtfile"
Set-ItemProperty -Path "HKCU:\Software\Classes\.wsh" -Name "(default)" -Value "txtfile"
Set-ItemProperty -Path "HKCU:\Software\Classes\.scr" -Name "(default)" -Value "txtfile"
Set-ItemProperty -Path "HKCU:\Software\Classes\.url" -Name "(default)" -Value "txtfile" 
Set-ItemProperty -Path "HKCU:\Software\Classes\.wcx" -Name "(default)" -Value "txtfile"


###### SOURCES ######

# https://seclists.org/fulldisclosure/2019/Mar/27 

# https://www.trustwave.com/Resources/SpiderLabs-Blog/Firework--Leveraging-Microsoft-Workspaces-in-a-Penetration-Test/

# https://bohops.com/2018/08/18/abusing-the-com-registry-structure-part-2-loading-techniques-for-evasion-and-persistence/

# https://www.trustwave.com/Resources/SpiderLabs-Blog/Firework--Leveraging-Microsoft-Workspaces-in-a-Penetration-Test/
# ftype wsxfile="%systemroot%\system32\notepad.exe" "%1" :: does not work use mitigation from the article above
# https://posts.specterops.io/the-tale-of-settingcontent-ms-files-f1ea253e4d39
# Changing back:
# reg add "HKCR\SettingContent\Shell\Open\Command" /v DelegateExecute /t REG_SZ /d "{0c194cb2-2959-4d14-8964-37fd3e48c32d}" /f
# reg delete "HKCR\SettingContent\Shell\Open\Command" /v DelegateExecute /f
# reg add "HKCR\SettingContent\Shell\Open\Command" /v DelegateExecute /t REG_SZ /d "" /f
# https://rinseandrepeatanalysis.blogspot.com/2018/09/dde-downloaders-excel-abuse-and.html

# https://posts.specterops.io/remote-code-execution-via-path-traversal-in-the-device-metadata-authoring-wizard-a0d5839fc54f

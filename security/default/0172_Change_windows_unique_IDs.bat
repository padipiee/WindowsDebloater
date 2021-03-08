::@@@Change_windows_unique_IDs@@@
::@N@Change Windows and hardware identifiers so that change system fingerprint@N@
::@@@Python@@@ @@@fingerprint@@@ @@@CryptoMachineGuid@@@ @@@MACadress@@@
::https://github.com/vektort13/AntiOS
::New version Python : https://github.com/vektort13/AntiOS

:: https://wikileaks.org/ciav7p1/cms/page_42991626.html

:: HKLM\Software\Microsoft\Cryptography\MachineGuid
::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MachineGuid

:: https://www.xspdf.com/resolution/20315617.html

:: https://github.com/denisbrodbeck/machineid

:: https://r3mrum.wordpress.com/2017/05/07/loki-bot-atrifacts/

reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography /v MachineGuid

::Windows Product Key - This key holds the obfuscated product key for the licensed version of Windows. 
::Check Getting Windows License for code snippets to deobfuscate the key.
::HKLM\Software\Microsoft\Windows NT\CurrentVersion\DigitalProductId
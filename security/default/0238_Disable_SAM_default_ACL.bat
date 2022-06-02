::https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-36934

::Volume Shadow Copy Service (VSS)
vssadmin delete shadows /for=c:
::vssadmin 1.1 - Volume Shadow Copy Service administrative command-line tool
::(C) Copyright 2001-2013 Microsoft Corp.
:: Do you really want to delete 4 shadow copies (Y/N): [N]? Y
:: Successfully deleted 4 shadow copies.

icacls %windir%\system32\config\*.* /inheritance:e

::Successfully processed 70 files; Failed processing 0 files
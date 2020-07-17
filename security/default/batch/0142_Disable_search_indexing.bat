
:: https://github.com/AcaplaStd/WindowsConfigurator/blob/master/doit.cmd
:: Disable search indexing


set conf=Y
set /p "conf= Disable search indexing? [Y/n] "
if "%conf%" neq "Y" if "%Conf%" neq "y" goto endsearch
echo Disabling search indexing...
sc config WSearch start= disabled
sc stop WSearch
%psexec% cmd.exe /c del /f /q C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb
echo Done!
:endsearch
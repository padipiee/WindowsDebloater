:: Disable Edge password manager to encourage use of proper password manager
:: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.MicrosoftEdge::AllowPasswordManager
:: @N@Disable_Edge_password_manager@N@
:: @@@Microsoft Edge@@@ @@@FormSuggest Passwords@@@
reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "FormSuggest Passwords" /t REG_SZ /d no /f



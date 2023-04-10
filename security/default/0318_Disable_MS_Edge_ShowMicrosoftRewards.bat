:: Disable MS Edge ShowMicrosoftRewards
:: https://admx.help/?Category=EdgeChromium&Policy=Microsoft.Policies.Edge::ShowMicrosoftRewards

reg query "HKLM\Software\Policies\Microsoft\Edge"
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "ShowMicrosoftRewards" /t REG_DWORD /d "1" /f
reg query "HKLM\Software\Policies\Microsoft\Edge"






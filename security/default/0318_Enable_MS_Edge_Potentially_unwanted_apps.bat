:: Configure MS Edge SmartScreenPuaEnabled
:: https://admx.help/?Category=EdgeChromium&Policy=Microsoft.Policies.Edge::SmartScreenPuaEnabled

reg query "HKLM\Software\Policies\Microsoft\Edge"
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "SmartScreenPuaEnabled" /t REG_DWORD /d "0x00000001" /f
reg query "HKLM\Software\Policies\Microsoft\Edge"






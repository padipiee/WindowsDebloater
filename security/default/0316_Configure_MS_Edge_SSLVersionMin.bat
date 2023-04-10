:: Configure MS Edge TLS minimum protocol

reg query "HKLM\Software\Policies\Microsoft\Edge"
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "SSLVersionMin" /t REG_SZ /d "tls1.2^@" /f
reg query "HKLM\Software\Policies\Microsoft\Edge"






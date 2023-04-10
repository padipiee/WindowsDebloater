:: Query cipher suite order
:: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.CypherStrength::SSLCipherSuiteOrder
:: https://learn.microsoft.com/en-us/windows/win32/secauthn/tls-cipher-suites-in-windows-11

reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002" 


reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HTTP\Parameters"
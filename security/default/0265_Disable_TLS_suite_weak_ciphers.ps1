## Get Friendly names from USB devices
Get-TlsCipherSuite

# Enable TLS_CHACHA20_POLY1305_SHA256 Cipher Suite which is available but not enabled by default in Windows 11
Enable-TlsCipherSuite -Name "TLS_CHACHA20_POLY1305_SHA256" -Position 0
https://ciphersuite.info/search/?q=TLS_DHE_RSA_WITH_AES_128_GCM_SHA256

### Disable NULL Cipher
# Disable NULL Cipher Suites - 1 
Disable-TlsCipherSuite TLS_RSA_WITH_NULL_SHA256
# Disable NULL Cipher Suites - 2
Disable-TlsCipherSuite TLS_RSA_WITH_NULL_SHA
# Disable NULL Cipher Suites - 3
Disable-TlsCipherSuite TLS_PSK_WITH_NULL_SHA384
# Disable NULL Cipher Suites - 4
Disable-TlsCipherSuite TLS_PSK_WITH_NULL_SHA256


##Disable non compliant to PFS
#https://ciphersuite.info/cs/TLS_RSA_WITH_AES_256_GCM_SHA384/
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_256_GCM_SHA384"
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_128_GCM_SHA256"


##Disable CBC
#https://ciphersuite.info/cs/TLS_RSA_WITH_AES_256_CBC_SHA256/
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_256_CBC_SHA256"
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_128_CBC_SHA256"
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_256_CBC_SHA"
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_128_CBC_SHA"

###Disable Pre-Shared Key (PSK)
Disable-TlsCipherSuite -Name "TLS_PSK_WITH_AES_256_GCM_SHA384" 
Disable-TlsCipherSuite -Name "TLS_PSK_WITH_AES_128_GCM_SHA256"
Disable-TlsCipherSuite -Name "TLS_PSK_WITH_AES_256_CBC_SHA384"
Disable-TlsCipherSuite -Name "TLS_PSK_WITH_AES_128_CBC_SHA256" 

###Disable old 3DEC + CBC
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_3DES_EDE_CBC_SHA"



#https://ciphersuite.info/cs/TLS_RSA_WITH_AES_128_GCM_SHA256/
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_128_GCM_SHA256"
#https://ciphersuite.info/cs/TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA/
Disable-TlsCipherSuite -Name "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"
Disable-TlsCipherSuite -Name "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA"
Disable-TlsCipherSuite -Name "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA"



###
# Enabling Diffie–Hellman based key exchange algorithms
# TLS_DHE_RSA_WITH_AES_128_GCM_SHA256
# must be already available by default according to Microsoft Docs but it isn't, on Windows 11 insider dev build 25272
# https://learn.microsoft.com/en-us/windows/win32/secauthn/tls-cipher-suites-in-windows-11
Enable-TlsCipherSuite -Name "TLS_DHE_RSA_WITH_AES_128_GCM_SHA256"


###
Get-TlsCipherSuite

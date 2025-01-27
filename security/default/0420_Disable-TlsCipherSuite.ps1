# Disable NULL Cipher Suites - 1
Disable-TlsCipherSuite TLS_RSA_WITH_NULL_SHA256
# Disable NULL Cipher Suites - 2
Disable-TlsCipherSuite TLS_RSA_WITH_NULL_SHA
# Disable NULL Cipher Suites - 3
Disable-TlsCipherSuite TLS_PSK_WITH_NULL_SHA384
# Disable NULL Cipher Suites - 4
Disable-TlsCipherSuite TLS_PSK_WITH_NULL_SHA256

# disabling weak cipher suites
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_256_GCM_SHA384"
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_128_GCM_SHA256"
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_256_CBC_SHA256" 
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_128_CBC_SHA256"
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_256_CBC_SHA"
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_AES_128_CBC_SHA"
Disable-TlsCipherSuite -Name "TLS_PSK_WITH_AES_256_GCM_SHA384" 
Disable-TlsCipherSuite -Name "TLS_PSK_WITH_AES_128_GCM_SHA256"
Disable-TlsCipherSuite -Name "TLS_PSK_WITH_AES_256_CBC_SHA384"
Disable-TlsCipherSuite -Name "TLS_PSK_WITH_AES_128_CBC_SHA256" 
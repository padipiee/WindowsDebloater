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

# Disable 3DES (Triple DES) cipher suites
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_3DES_EDE_CBC_SHA"
Disable-TlsCipherSuite -Name "TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA"
Disable-TlsCipherSuite -Name "TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA"

# Disable RC4-based cipher suites
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_RC4_128_SHA"
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_RC4_128_MD5"
Disable-TlsCipherSuite -Name "TLS_ECDHE_ECDSA_WITH_RC4_128_SHA"
Disable-TlsCipherSuite -Name "TLS_ECDHE_RSA_WITH_RC4_128_SHA"

# Disable anonymous DH suites (no authentication)
Disable-TlsCipherSuite -Name "TLS_DH_anon_WITH_RC4_128_MD5"
Disable-TlsCipherSuite -Name "TLS_DH_anon_WITH_AES_256_CBC_SHA256"
Disable-TlsCipherSuite -Name "TLS_DH_anon_WITH_AES_128_CBC_SHA256"

# Disable MD5-based suites
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_NULL_MD5"
Disable-TlsCipherSuite -Name "TLS_RSA_EXPORT_WITH_RC4_40_MD5"
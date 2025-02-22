# Disable weak Cipher Suites
# if errror message 0xD0000225 is thrown, it probabley means the cipher suite is already disabled

function DisableAndReport {
    param($CipherSuiteName)
    try {
        Disable-TlsCipherSuite -Name $CipherSuiteName
        Write-Host "Disabled $CipherSuiteName"
    } catch {
        if ($_.Exception.Message -like "*0xD0000225*") {
            Write-Host "Cipher suite $CipherSuiteName is already disabled. See https://stackoverflow.com/questions/65213393/why-do-i-get-exception-from-hresult-0xd0000225-when-running-disable-tlsciphersu"
        } else {
            Write-Host "Failed to disable $CipherSuiteName. $_"
        }
    }
}

DisableAndReport "TLS_RSA_WITH_NULL_SHA256"
# Disable NULL Cipher Suites - 2
DisableAndReport "TLS_RSA_WITH_NULL_SHA"
# Disable NULL Cipher Suites - 3
DisableAndReport "TLS_PSK_WITH_NULL_SHA384"
# Disable NULL Cipher Suites - 4
DisableAndReport "TLS_PSK_WITH_NULL_SHA256"

# disabling weak cipher suites
DisableAndReport "TLS_RSA_WITH_AES_256_GCM_SHA384"
DisableAndReport "TLS_RSA_WITH_AES_128_GCM_SHA256"
DisableAndReport "TLS_RSA_WITH_AES_256_CBC_SHA256"
DisableAndReport "TLS_RSA_WITH_AES_128_CBC_SHA256"
DisableAndReport "TLS_RSA_WITH_AES_256_CBC_SHA"
DisableAndReport "TLS_RSA_WITH_AES_128_CBC_SHA"
DisableAndReport "TLS_PSK_WITH_AES_256_GCM_SHA384"
DisableAndReport "TLS_PSK_WITH_AES_128_GCM_SHA256"
DisableAndReport "TLS_PSK_WITH_AES_256_CBC_SHA384"
DisableAndReport "TLS_PSK_WITH_AES_128_CBC_SHA256"

# Disable 3DES (Triple DES) cipher suites
DisableAndReport "TLS_RSA_WITH_3DES_EDE_CBC_SHA"
DisableAndReport "TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA"
DisableAndReport "TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA"

# Disable RC4-based cipher suites
DisableAndReport "TLS_RSA_WITH_RC4_128_SHA"
DisableAndReport "TLS_RSA_WITH_RC4_128_MD5"
DisableAndReport "TLS_ECDHE_ECDSA_WITH_RC4_128_SHA"
DisableAndReport "TLS_ECDHE_RSA_WITH_RC4_128_SHA"

# Disable anonymous DH suites (no authentication)
DisableAndReport "TLS_DH_anon_WITH_RC4_128_MD5"
DisableAndReport "TLS_DH_anon_WITH_AES_256_CBC_SHA256"
DisableAndReport "TLS_DH_anon_WITH_AES_128_CBC_SHA256"

# Disable MD5-based suites
DisableAndReport "TLS_RSA_WITH_NULL_MD5"
DisableAndReport "TLS_RSA_EXPORT_WITH_RC4_40_MD5"

DisableAndReport "TLS_DHE_RSA_WITH_CAMELLIA_256_CBC_SHA"
DisableAndReport "TLS_DHE_RSA_WITH_CAMELLIA_128_CBC_SHA"
DisableAndReport "TLS_DHE_RSA_WITH_ARIA_256_GCM_SHA384"
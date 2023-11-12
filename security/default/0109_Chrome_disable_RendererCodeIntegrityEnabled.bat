
::Disabling RendererCodeIntegrityEnabled !! Only if required !
::Renderer Code Integrity security feature enabled by default on Windows 10

REG ADD "HKLM\Software\Policies\Google\Chrome" /v RendererCodeIntegrityEnabled /t REG_DWORD /d 0
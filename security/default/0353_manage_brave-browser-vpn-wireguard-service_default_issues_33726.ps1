#brave-vpn-wireguard-service

#Starting with product version 1.59.117 on Windows, WireGuard is used as the default for Brave VPN ??!!!
#With product version 1.57.47, Brave will install a service Brave Vpn Wireguard Service if a user has admin privileges. This service is marked as Manual start and is not started. The binary is also installed on disk in the directory the the browser binaries are installed.

# Status : confirmed as a problematic BUG to be fixed begining of 2024 !
#https://github.com/brave/brave-browser/issues/33592

# 
#brave://flags/#brave-vpn
#

## Delete the service (if needed)
sc.exe delete BraveVpnWireguardService
sc.exe delete BraveVpnService

# Other references:
#https://en.wikipedia.org/wiki/WireGuard
#
#https://arstechnica.com/gadgets/2018/08/wireguard-vpn-review-fast-connections-amaze-but-windows-support-needs-to-happen/
#
#https://www.theverge.com/2023/10/20/23925192/brave-browser-vpn-windows-11
#
#https://www.androidpolice.com/brave-browser-windows-vpn-without-user-consent/
#
# https://git.zx2c4.com/wireguard-windows/
#
# https://www.wireguard.com/
#
# https://news.ycombinator.com/item?id=30719370
#
# https://lists.zx2c4.com/pipermail/wireguard/2021-March/006494.html
# 
#"C:\Program Files (x86)\BraveSoftware\Brave-Browser\Application\120.1.61.109\BraveVpnWireguardService\brave_vpn_wireguard_service.exe"
#
#"C:\Program Files (x86)\BraveSoftware\Brave-Browser\Application\120.1.61.109\brave_vpn_helper.exe"
#
#C:\Users\xxx>"C:\Program Files (x86)\BraveSoftware\Brave-Browser\Application\120.1.61.109\brave_vpn_helper.exe"
#[1228/073303.989:ERROR:file_io_win.cc(181)] CreateFile C:\ProgramData\BraveSoftware\BraveVpnService\Crashpad\settings.dat: Access is denied. (0x5)
#[1228/073303.990:ERROR:file_io_win.cc(181)] CreateFile C:\ProgramData\BraveSoftware\BraveVpnService\Crashpad\settings.dat: Access is denied. (0x5)
#[1228/073303.990:ERROR:service_main.cc(72)] Failed to connect to the service control manager:1063
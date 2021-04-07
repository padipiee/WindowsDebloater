
# Purpose
Scripts to harden Windows 10.
Assist to remove unnecessary Windows 10 apps, disable Telemetry, inactivate bloatware and disable spying default features.
Attempts to improve security and privacy posture.

# Usage
Use scripts in MS cmd batch, powershell, python, ansible.


# Sources / Others tools sources /Credits
This is using various ideas from various initial sources.
With the time I added plenty of  variants, modifications and optimizations of my own.

Include some original scripts at the time this project was initiated (subfolder are for credits and are not maintained, check the original repo ), essentially :
- Sycnex/Windows10Debloater
- IntergalacticApps/make_windows10_great_again.bat
- 10se1ucgo/DisableWinTracking

* Applocker hardening
  * https://dfir-blog.com/2016/01/03/protecting-windows-networks-applocker/
  * Powershell focus: https://www.sixdub.net/?p=367, http://www.scip.ch/en/?labs.20150507, https://www.sysadmins.lv/blog-en/powershell-50-and-applocker-when-security-doesnt-mean-security.aspx

* Securing Windows Workstations: Developing a Secure Baseline: https://adsecurity.org/?p=3299

* [Validation with inspec](https://github.com/juju4/windows-baseline)

* [SecurityWithoutBorders HardenTools](https://github.com/securitywithoutborders/hardentools)

## Others tools : ANSIBLE
* [ansible-harden-windows](https://github.com/juju4/ansible-harden-windows) (credit juju4)


## License
BSD 2-clause

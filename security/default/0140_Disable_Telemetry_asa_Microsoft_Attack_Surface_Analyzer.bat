

:: AttackSurfaceAnalyzer v.2.2.56+a8b3fd6c3f
::This application collects usage data to help us improve Attack Surface Analyzer.
:: For our privacy policy visit: https://github.com/Microsoft/AttackSurfaceAnalyzer/blob/master/PRIVACY.md.
::To disable telemetry run Attack Surface Analyzer with these arguments: 'config --telemetry-opt-out'.
:: https://github.com/microsoft/AttackSurfaceAnalyzer

$HOME\.dotnet\tools>asa config --telemetry-opt-out

::Exemple :
:: C:\Users\$user\.dotnet\tools
::Your telemetry opt out setting is now Opted out.

:: https://github.com/Microsoft/AttackSurfaceAnalyzer/wiki
::CLI Mode
::To start a default all collectors run: asa collect -a
:: To compare the last two collection runs: asa export-collect


::The basic steps for running Attack Surface Analyzer are:
::Take a baseline scan on a clean machine.
::Install and run your product or application. Optionally make these two separate scans to distinguish between install vs run changes that are made.
::Take a product scan.
::Run data analysis.
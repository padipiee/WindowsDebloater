REM This batch script searches for problematic drivers on the system using the driverquery.exe command. The output is formatted as a table and includes additional information about each driver, such as its signed status.
:: Search problematic drivers
:: https://www.loldrivers.io/  

driverquery.exe /fo table /si
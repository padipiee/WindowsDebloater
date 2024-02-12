
:: Set Formats to Metric
:: reg add "HKCU\Control Panel\International" /v "iDigits" /t REG_SZ /d "2" /f
:: reg add "HKCU\Control Panel\International" /v "iLZero" /t REG_SZ /d "1" /f
:: reg add "HKCU\Control Panel\International" /v "iMeasure" /t REG_SZ /d "0" /f
:: reg add "HKCU\Control Panel\International" /v "iNegNumber" /t REG_SZ /d "1" /f
:: reg add "HKCU\Control Panel\International" /v "iPaperSize" /t REG_SZ /d "1" /f
:: reg add "HKCU\Control Panel\International" /v "iTLZero" /t REG_SZ /d "1" /f
:: reg add "HKCU\Control Panel\International" /v "sDecimal" /t REG_SZ /d "," /f
:: reg add "HKCU\Control Panel\International" /v "sNativeDigits" /t REG_SZ /d "0123456789" /f
:: reg add "HKCU\Control Panel\International" /v "sNegativeSign" /t REG_SZ /d "-" /f
:: reg add "HKCU\Control Panel\International" /v "sPositiveSign" /t REG_SZ /d "" /f
:: reg add "HKCU\Control Panel\International" /v "NumShape" /t REG_SZ /d "1" /f

:: :: :: :: A config :: 
:: s1159    REG_SZ    AM
:: s2359    REG_SZ    PM
:: sCurrency    REG_SZ    $
:: sDecimal    REG_SZ    .
:: sGrouping    REG_SZ    3;0
:: sList    REG_SZ    ,
:: sMonDecimalSep    REG_SZ    .
:: sMonGrouping    REG_SZ    3;0
:: sMonThousandSep    REG_SZ    ,
:: sNativeDigits    REG_SZ    0123456789
:: sNegativeSign    REG_SZ    -
:: sPositiveSign    REG_SZ
:: sThousand    REG_SZ    ,
:: sTime    REG_SZ    :
:: sTimeFormat    REG_SZ    h:mm:ss tt
:: sShortTime    REG_SZ    h:mm tt
:: iCalendarType    REG_SZ    1
:: iCountry    REG_SZ    1
:: iCurrDigits    REG_SZ    2
:: iCurrency    REG_SZ    0
:: iDigits    REG_SZ    2
:: NumShape    REG_SZ    1
:: iFirstDayOfWeek    REG_SZ    6
:: iFirstWeekOfYear    REG_SZ    0
:: iLZero    REG_SZ    1
:: iNegNumber    REG_SZ    1
:: iPaperSize    REG_SZ    1
:: iTime    REG_SZ    0
:: iTimePrefix    REG_SZ    0
:: iTLZero    REG_SZ    0
:: Locale    REG_SZ    00001009
:: LocaleName    REG_SZ    en-CA
:: sCountry    REG_SZ    Canada
:: sDate    REG_SZ    -
:: sLanguage    REG_SZ    ENC
:: sLongDate    REG_SZ    MMMM d, yyyy
:: sShortDate    REG_SZ    yyyy-MM-dd
:: sYearMonth    REG_SZ    MMMM, yyyy
:: iDate    REG_SZ    2
:: iMeasure    REG_SZ    0
:: iNegCurr    REG_SZ    1
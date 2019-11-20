@echo off
:: BatchGotAdmin
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------

::ENTER YOUR CODE BELOW:
@ECHO off

cls
:start
ECHO :::::::::: Arthur Set Route IP ::::::::::
ECHO.
ECHO [1] Reset Route Table
ECHO [2] Set Route Table for XXX
ECHO [3] Set Route Table for XXX (P)
ECHO [0] Exit
ECHO.
ECHO :::::::::::::::::::::::::::::::::::::::::::::
ECHO.

set choice=
set /p choice=Type the number to print text.
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='0' goto end
if '%choice%'=='1' goto reset
if '%choice%'=='2' goto xxx
if '%choice%'=='3' goto xxx_p
ECHO "%choice%" is not valid, try again
ECHO.

goto start
:reset
cls
route /f
timeout /t 5 /nobreak
goto end

goto start
:xxx
cls
route delete 192.168.0.0
route delete 172.20.0.0
route delete 0.0.0.0
route delete 10.0.0.0
route add 0.0.0.0 mask 0.0.0.0 192.168.43.1 metric 10
route add 10.0.0.0 mask 255.0.0.0 10.249.240.10 metric 20
timeout /t 5 /nobreak
goto end

goto start
:xxx_p
cls
route delete 192.168.0.0
route delete 172.20.0.0
route delete 0.0.0.0
route delete 10.0.0.0

route add 192.168.0.0 mask 0.0.0.0 192.168.43.1 metric 10 -p
route add 172.20.0.0 mask 255.0.0.0 172.20.10.1 metric 10 -p

route add 0.0.0.0 mask 0.0.0.0 192.168.43.1 metric 20 -p
route add 0.0.0.0 mask 0.0.0.0 172.20.10.1 metric 20 -p

route add 10.0.0.0 mask 255.0.0.0 10.249.240.10 metric 30 -p
route add 10.0.0.0 mask 255.0.0.0 10.249.128.10 metric 30 -p
timeout /t 5 /nobreak
goto end


:bye
ECHO BYE
timeout /t 5 /nobreak
goto end

:end
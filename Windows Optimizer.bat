@echo off
net session >nul 2>&1 || (echo This script must be run as administrator.& pause & exit /b)
echo starting...
timeout /t 1 >nul
timeout /t 5

echo ---------------------------------------------------------------------
echo ---------------------------------------------------------------------
timeout /t 2 >nul

:: 1 - Temp Folders
echo cleaning temp files...

del /q /f /s "%temp%\*" >nul 2>&1
del /q /f "%systemroot%\Prefetch\*.*" >nul 2>&1
echo temp files cleaned!

echo ---------------------------------------------------------------------
echo ---------------------------------------------------------------------
timeout /t 2 >nul

:: 2 - Network Troubleshooting / Optimizations (flushing the dns cache, resetting the TCP/IP stack)
echo Tuning Network Settings...

ipconfig /flushdns >nul
netsh winsock reset >nul
netsh int ip reset >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkthrottlingIndex /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
echo network optimized!

echo ---------------------------------------------------------------------
echo ---------------------------------------------------------------------
timeout /t 2 >nul

:: 3 - Removing unnecessary services 
echo stopping services...

sc stop Sysmain >nul
sc config Sysmain start= disabled >nul
sc stop Spooler >nul
sc config Spooler start= disabled >nul
sc stop lfsvc >nul
sc config lfsvc start= disabled >nul
sc stop DiagTrack >nul
sc config DiagTrack start= disabled >nul
sc stop TabletInputService >nul
sc config TabletInputService start= disabled >nul
sc stop WSearch >nul
sc config WSearch start= disabled >nul

echo ---------------------------------------------------------------------
echo ---------------------------------------------------------------------
timeout /t 2 >nul
echo COMPLETE! Made by phoenixy-scripts
pause
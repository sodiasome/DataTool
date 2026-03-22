@echo off
REM ============================================================
REM build.bat — Windows build script for DataTool
REM
REM This script works around the jom error:
REM   "cannot open ...\AppData\Local\Temp\*.jom for write"
REM which occurs when the Windows username (or TEMP path) contains
REM non-ASCII characters (e.g. Chinese).
REM
REM It redirects TEMP and TMP to C:\Temp before invoking jom so
REM that jom can always write its temporary files to an ASCII-safe
REM location.
REM ============================================================

REM Create a safe, ASCII-only temp directory if it does not exist.
if not exist C:\Temp mkdir C:\Temp
if not exist C:\Temp (
    echo [ERROR] Could not create C:\Temp. Run this script as Administrator,
    echo         or manually create C:\Temp and grant write permission to your user.
    exit /b 1
)

REM Override TEMP/TMP for this process and all child processes.
set TEMP=C:\Temp
set TMP=C:\Temp

REM Run qmake then jom (falls back to nmake if jom is not found).
qmake DataTool.pro -spec win32-msvc
if %errorlevel% neq 0 (
    echo [ERROR] qmake failed.
    exit /b %errorlevel%
)

where jom >nul 2>&1
if %errorlevel% equ 0 (
    echo [INFO] Building with jom ...
    jom
) else (
    echo [INFO] jom not found, building with nmake ...
    nmake
)

if %errorlevel% neq 0 (
    echo [ERROR] Build failed.
    exit /b %errorlevel%
)

echo [INFO] Build succeeded. Output is in the .\build\ directory.

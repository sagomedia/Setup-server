@echo off
REM ==============================================================================
REM 24/7 HOME SERVER SETUP FOR WINDOWS (1-CLICK BATCH)
REM ==============================================================================
title 24/7 Home Server Setup
color 0B

echo ============================================================================
echo   SAGO 24/7 HOME SERVER - WINDOWS 1-CLICK LAUNCHER
echo ============================================================================
echo.

REM 1. Check if Docker Desktop is running
docker --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Docker is not detected!
    echo Please install Docker Desktop from https://www.docker.com/products/docker-desktop/
    echo Make sure Docker Desktop is OPEN and running.
    echo.
    pause
    exit /b 1
)

echo [1/5] Docker is running properly.

REM 2. Create .env from template if missing
if not exist .env (
    echo [2/5] Creating .env configuration from template...
    copy .env.example .env >nul
)

REM 3. Create persistent directories
echo [3/5] Initializing storage directories...
if not exist data\files mkdir data\files
if not exist data\filebrowser mkdir data\filebrowser
if not exist data\jellyfin\config mkdir data\jellyfin\config
if not exist data\jellyfin\cache mkdir data\jellyfin\cache
if not exist data\media\movies mkdir data\media\movies
if not exist data\media\shows mkdir data\media\shows
if not exist data\immich\photos mkdir data\immich\photos
if not exist data\immich\postgres mkdir data\immich\postgres
if not exist data\immich\model-cache mkdir data\immich\model-cache
if not exist config\nginx\html mkdir config\nginx\html

REM 4. Stop containers before database initialization
echo [4/5] Pre-configuring FileBrowser admin credentials...
docker compose down --remove-orphans >nul 2>&1
if not exist "data\filebrowser\filebrowser.db" (
    docker run --rm -v "%cd%\data\filebrowser:/database" filebrowser/filebrowser config init -d /database/filebrowser.db >nul 2>&1
    docker run --rm -v "%cd%\data\filebrowser:/database" filebrowser/filebrowser users add admin admin12345678 --perm.admin -d /database/filebrowser.db >nul 2>&1
) else (
    docker run --rm -v "%cd%\data\filebrowser:/database" filebrowser/filebrowser users update admin --password admin12345678 -d /database/filebrowser.db >nul 2>&1
)

REM 5. Launch containers
echo [5/5] Launching Home Server Containers...
docker compose up -d

REM 6. Check Tailscale on Windows
set TS_CMD=tailscale
where tailscale >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    if exist "%ProgramFiles%\Tailscale\tailscale.exe" (
        set TS_CMD="%ProgramFiles%\Tailscale\tailscale.exe"
    )
)

set TS_IP=
for /f "delims=" %%t in ('%TS_CMD% ip -4 2^>nul') do set TS_IP=%%t

if "%TS_IP%"=="" (
    echo.
    echo ============================================================================
    echo   [OPTIONAL] Worldwide 5G Access via Tailscale
    echo   Install Tailscale for Windows: https://tailscale.com/download/windows
    echo ============================================================================
)

REM Detect Local IP on Windows
set LOCAL_IP=localhost
for /f "tokens=4" %%a in ('route print 0.0.0.0 2^>nul ^| findstr 0.0.0.0') do (
    set LOCAL_IP=%%a
    goto :ip_done
)
:ip_done

echo.
echo ============================================================================
echo   CONGRATULATIONS! YOUR 24/7 PRIVATE HOME SERVER IS LIVE!
echo ============================================================================
echo.
echo   HOW TO OPEN ON YOUR PHONE AND TABLET (Home WiFi):
echo      http://%LOCAL_IP%:8000
echo.
if not "%TS_IP%"=="" (
    echo   HOW TO OPEN ON YOUR PHONE ANYWHERE IN THE WORLD (5G Data):
    echo      http://%TS_IP%:8000
    echo.
)
echo   HOW TO OPEN ON THIS COMPUTER:
echo      http://localhost:8000
echo.
echo   HOW TO WATCH ON SMART TV (Android TV / FireTV):
echo      Open Jellyfin app on TV - Auto-detects this server on your WiFi!
echo.
echo   FILE BROWSER LOGIN CREDENTIALS:
echo      Username : admin
echo      Password : admin12345678
echo.
echo ============================================================================
echo.

REM Automatically open the dashboard in default browser
timeout /t 3 >nul
start http://localhost:8000

pause

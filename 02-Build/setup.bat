@echo off
REM ==============================================================================
REM 24/7 HOME SERVER SETUP FOR WINDOWS (1-CLICK BATCH)
REM ==============================================================================
title 24/7 Home Server Setup

echo =========================================================
echo  24/7 HOME SERVER (WINDOWS 1-CLICK)
echo =========================================================
echo.

REM 1. Check if Docker Desktop is installed/running
docker --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Docker is not detected!
    echo Please download and install Docker Desktop for Windows from:
    echo https://www.docker.com/products/docker-desktop/
    echo Ensure 'WSL 2 backend' is selected during install.
    pause
    exit /b 1
)

echo [OK] Docker is installed and running.

REM 2. Create .env from template if missing
if not exist .env (
    echo [INFO] Creating .env configuration from template...
    copy .env.example .env >nul
)

REM 3. Create persistent directories
echo [INFO] Pre-creating persistent storage folders...
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

REM 4. Stop containers before database operations
docker compose down --remove-orphans >nul 2>&1

REM 5. Pre-configure FileBrowser admin credentials (admin / admin12345678)
echo [INFO] Configuring FileBrowser admin password...
docker run --rm -v "%cd%\data\filebrowser:/database" filebrowser/filebrowser users add admin admin12345678 --perm.admin -d /database/filebrowser.db >nul 2>&1
docker run --rm -v "%cd%\data\filebrowser:/database" filebrowser/filebrowser users update admin --password admin12345678 -d /database/filebrowser.db >nul 2>&1

REM 6. Launch containers
echo [INFO] Launching Home Server Containers...
docker compose up -d

REM 7. Dynamically Detect Network IP Addresses on Windows
set LOCAL_IP=localhost
for /f "tokens=4" %%a in ('route print 0.0.0.0 ^| findstr 0.0.0.0') do (
    set LOCAL_IP=%%a
    goto :ip_found
)
:ip_found

set TAILSCALE_IP=
for /f "delims=" %%t in ('tailscale ip -4 2^>nul') do set TAILSCALE_IP=%%t

echo.
echo ============================================================================
echo  CONGRATULATIONS! YOUR 24/7 PRIVATE HOME SERVER IS LIVE!
echo ============================================================================
echo.
echo  HOW TO OPEN ON YOUR PHONE ^& TABLET (Home WiFi):
echo     http://%LOCAL_IP%:8000
echo.
if defined TAILSCALE_IP (
echo  HOW TO OPEN ON YOUR PHONE ANYWHERE IN THE WORLD (5G Data):
echo     http://%TAILSCALE_IP%:8000
echo.
) else (
echo  For Worldwide 5G Access: Run Tailscale (see tailscale-guide.md)
echo.
)
echo  HOW TO OPEN ON THIS COMPUTER:
echo     http://localhost:8000
echo.
echo  HOW TO WATCH ON SMART TV (Android TV / FireTV):
echo     Open the Jellyfin app on TV - Auto-detects this server on your WiFi!
echo.
echo  FILE BROWSER LOGIN CREDENTIALS:
echo     Username : admin
echo     Password : admin12345678
echo ============================================================================
echo.
pause

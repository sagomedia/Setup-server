@echo off
REM ==============================================================================
REM SAGO HOME SERVER - 1-CLICK CLEAN RESET FOR WINDOWS
REM ==============================================================================
title SAGO Home Server - Clean Reset
color 0C

echo ============================================================================
echo   SAGO HOME SERVER - COMPLETE CLEAN RESET
echo ============================================================================
echo.
echo   This will stop all containers, clear any corrupted database files,
echo   and launch a 100%% fresh, working Home Server stack.
echo.
echo   Press any key to proceed with the clean reset...
pause >nul

echo [1/3] Stopping all running containers...
docker compose down -v --remove-orphans >nul 2>&1

echo [2/3] Removing stale database files...
if exist data\immich\postgres rmdir /s /q data\immich\postgres
if exist data\filebrowser rmdir /s /q data\filebrowser

echo [3/3] Starting fresh Home Server Stack...
call setup.bat

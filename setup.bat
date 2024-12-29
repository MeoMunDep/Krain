@echo off
title Krain Bot Setup and Run Script by @MeoMunDep
color 0A

:MENU
cls
echo =================================================================
echo    Krain BOT SETUP AND RUN SCRIPT by @MeoMunDep
echo =================================================================
echo.
echo Current directory: %CD%
echo.
echo 1. Install/Update Python Dependencies
echo 2. Create/Edit Configuration Files
echo 3. Run the Bot
echo 4. Exit
echo.
set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto INSTALL
if "%choice%"=="2" goto CONFIG
if "%choice%"=="3" goto RUN
if "%choice%"=="4" goto EXIT

:INSTALL
cls
echo Checking Python installation...
python --version > nul 2>&1
if errorlevel 1 (
    echo Python is not installed or not in PATH
    echo Please download Python 3.11.9 from: https://www.python.org/downloads/
    pause
    goto MENU
)

echo Installing/Updating Python dependencies...
python -m pip install --upgrade pip
pip install aiohttp requests cloudscraper pycryptodome fake-useragent aiohttp-proxy colorama
echo.
echo Dependencies installed successfully!
pause
goto MENU

:CONFIG
cls
echo Creating configuration files...



if not exist datas.txt (
    type nul > datas.txt
    echo Created datas.txt
)
if not exist wallets.txt (
    type nul > wallets.txt
    echo Created wallets.txt
)
if not exist proxies.txt (
    type nul > proxies.txt
    echo Created proxies.txt
)

echo.
echo Configuration files have been created/checked.
echo Please edit the files with your data before running the bot.
echo.
pause
goto MENU

:RUN
cls
echo Checking Python and configuration...
python --version > nul 2>&1
if errorlevel 1 (
    echo Python is not installed or not in PATH
    pause
    goto MENU
)

if not exist bot.py (
    echo Error: bot.py not found in current directory!
    pause
    goto MENU
)

echo Starting the bot...
cd dist && python bot.py
pause
goto MENU

:EXIT
exit

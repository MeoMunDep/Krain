#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' 

print_green() { echo -e "${GREEN}$1${NC}"; }
print_yellow() { echo -e "${YELLOW}$1${NC}"; }
print_red() { echo -e "${RED}$1${NC}"; }

chmod +x "$0"

check_python() {
    if ! command -v python3 &> /dev/null; then
        print_red "Python is not installed!"
        print_yellow "Please install Python 3.11.9 from your package manager or https://www.python.org/downloads/"
        exit 1
    fi
}

create_default_configs() {
    cat > configs.json << EOL
{
  "timeZone": "en-US",
  "rotateProxy": false,
  "skipInvalidProxy": false,
  "proxyRotationInterval": 2,
  "delayEachAccount": [5, 8],
  "timeToRestartAllAccounts": 300,
  "howManyAccountsRunInOneTime": 1,
  "referralCode": "X3JBFG"
}
EOL
}

while true; do
    clear
    echo "==============================================================="
    echo "    Krain BOT SETUP AND RUN SCRIPT by @MeoMunDep"
    echo "==============================================================="
    echo
    echo "Current directory: $(pwd)"
    echo
    echo "1. Install/Update Python Dependencies"
    echo "2. Create/Edit Configuration Files"
    echo "3. Run the Bot"
    echo "4. Exit"
    echo
    read -p "Enter your choice (1-4): " choice

    case $choice in
        1)
            clear
            print_yellow "Checking Python installation..."
            check_python
            
            print_yellow "Installing/Updating Python dependencies..."
            python3 -m pip install --upgrade pip
            python3 -m pip install aiohttp requests cloudscraper pycryptodome fake-useragent aiohttp-proxy colorama
            
            print_green "Dependencies installation completed!"
            read -p "Press Enter to continue..."
            ;;
        2)
            clear
            print_yellow "Setting up configuration files..."

            if [ ! -f configs.json ]; then
                create_default_configs
                print_green "Created configs.json with default values"
            fi

            for file in datas.txt wallets.txt proxies.txt; do
                if [ ! -f "$file" ]; then
                    touch "$file"
                    print_green "Created $file"
                fi
            done

            print_green "\nConfiguration files have been created/checked."
            print_yellow "Please edit the files with your data before running the bot."
            read -p "Press Enter to continue..."
            ;;
        3)
            clear
            print_yellow "Checking Python and configuration..."
            check_python

            if [ ! -f bot.py ]; then
                print_red "Error: bot.py not found in current directory!"
                read -p "Press Enter to continue..."
                continue
            fi

            print_green "Starting the bot..."
            cd dist && python bot.py
            read -p "Press Enter to continue..."
            ;;
        4)
            print_green "Exiting..."
            exit 0
            ;;
        *)
            print_red "Invalid option. Please try again."
            read -p "Press Enter to continue..."
            ;;
    esac
done

